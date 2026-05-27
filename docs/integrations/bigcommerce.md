# BigCommerce Integration

BigCommerce's **Google Analytics 4** native integration (Settings → Analytics → Google Analytics 4) emits standard GA4 ecommerce events to the dataLayer when enabled. If yours is set up, you only need to add the **identify** push.

## Step 1 — Verify GA4 events are firing

In Stencil themes, the GA4 connector pushes `view_item`, `add_to_cart`, `begin_checkout`, and `purchase` automatically. Verify on any product page:

```js
dataLayer.filter(e => ['view_item','add_to_cart','begin_checkout','purchase'].includes(e.event))
```

If empty, enable the GA4 integration in your BigCommerce admin before continuing.

## Step 2 — Add identify push in your Stencil theme

Edit `templates/layout/base.html`, add inside `<head>`:

```html
<script>
  window.dataLayer = window.dataLayer || [];
  {{#if customer}}
    window.dataLayer.push({
      event: 'retaint_identify',
      user: {
        email:    {{json customer.email}},
        fullName: {{json (concat customer.name)}}
      }
    });
  {{/if}}
</script>
```

## Step 3 — Add identify on checkout email blur

BigCommerce's optimized checkout doesn't always allow injecting custom scripts. Two options:

- **Option A — Script Manager**: Storefront → Script Manager → Create a Script → Location: "Order Confirmation" + "Checkout" → paste the same blur-listener snippet from the [Shopify guide](shopify.md#step-3--add-identify-on-checkout-email-blur), changing the selector to `input[name="email"]`.
- **Option B — Use the order completion identify**: skip the blur listener and rely on the `purchase` event to fire `retaint_identify` via a small CJS variable that pulls the email from `ecommerce` if you've included `customer_email` there.

## Step 4 — Verify

Same as the [Shopify verification step](shopify.md#step-4--verify).
