# Shopify Integration

Shopify emits GA4 ecommerce dataLayer events automatically once you enable the **Google & YouTube** sales channel or install a GA4 connector app (most stores already have one). If yours is set up correctly, the only thing you need to add is the **identify** push.

## Step 1 — Confirm Shopify is pushing GA4 events

Open any product page on your store, open the browser console, and run:

```js
dataLayer.filter(e => e.event && e.event.startsWith('view'))
```

You should see at least one `view_item` event with an `ecommerce.items` array. If you don't, install or configure a GA4 connector before continuing.

## Step 2 — Add the identify push for logged-in customers

Add to `layout/theme.liquid`, just before `</head>`:

```liquid
<script>
  window.dataLayer = window.dataLayer || [];
  {% if customer %}
    window.dataLayer.push({
      event: 'retaint_identify',
      user: {
        email:    {{ customer.email | json }},
        phone:    {{ customer.phone | json }},
        fullName: {{ customer.name | json }}
      }
    });
  {% endif %}
</script>
```

This fires `retaint_identify` on every page load for logged-in customers — sufficient for accounts-driven stores.

## Step 3 — Add identify on checkout email blur (recommended)

The checkout page in Shopify is rendered separately from your theme. Add this in **Settings → Checkout → Order status page → Additional scripts** (which also injects into checkout):

```html
<script>
  (function () {
    function attach() {
      var input = document.querySelector('input[name="checkout[email]"], input[type=email][name*="email"]');
      if (!input) return;
      input.addEventListener('blur', function () {
        var email = input.value.trim();
        if (!email || !/.+@.+\..+/.test(email)) return;
        window.dataLayer = window.dataLayer || [];
        window.dataLayer.push({ event: 'retaint_identify', user: { email: email } });
      });
    }
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', attach);
    } else {
      attach();
    }
  })();
</script>
```

> **Note:** Shopify Plus stores using Checkout Extensibility need a different approach — use a customer-account UI extension or the Pixel API. Out of scope for this v1 doc.

## Step 4 — Verify

In GTM Preview Mode, browse your store:

- Product page → `view_item` triggers `Retaint — Product Index` + `Retaint — Product View`
- Cart page → `view_cart` (no Retaint mapping by default — fine)
- Add to cart → `add_to_cart` triggers `Retaint — Add to Cart`
- Begin checkout → `begin_checkout` triggers `Retaint — Checkout Started`
- Enter email in checkout → `retaint_identify` triggers `Retaint — Identify`
- Complete order → `purchase` triggers `Retaint — Buy` + `Retaint — Order`

Cross-check with your Retaint dashboard for the corresponding event arrivals.
