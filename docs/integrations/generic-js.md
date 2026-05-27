# Generic JS — Custom Websites Without a Platform

If your site isn't on Shopify / BigCommerce / WooCommerce and doesn't already emit a GA4 ecommerce dataLayer, you'll write the pushes yourself. The good news: it's ~10 lines of vanilla JS per event.

## The pattern

Every push has the same shape:

```js
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({ event: '<event-name>', ...payload });
```

Push the event at the moment the action happens (button click, page load, form submit). The GTM container does the rest.

## Per-event snippets

### Product page load

Place at the bottom of every product detail page (PDP):

```html
<script>
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'view_item',
    ecommerce: {
      items: [{
        item_id: 'SKU-FROM-YOUR-BACKEND',
        item_name: 'Product name',
        price: 49.00,
        item_url: window.location.href,
        image_url: 'https://cdn.example.com/p/sku.jpg'
      }]
    }
  });
</script>
```

### Category / collection page load

```html
<script>
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'view_item_list',
    ecommerce: { item_list_name: 'Category name' }
  });
</script>
```

### Search results page load

```html
<script>
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'search',
    search_term: new URLSearchParams(location.search).get('q') || ''
  });
</script>
```

### Add-to-cart button click

```js
document.querySelector('.add-to-cart').addEventListener('click', function () {
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'add_to_cart',
    ecommerce: {
      items: [{
        item_id: 'SKU',
        quantity: 1,
        item_url: window.location.href
      }]
    }
  });
});
```

### Checkout button click (after form filled)

```js
document.querySelector('button[type=submit].checkout').addEventListener('click', function () {
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'begin_checkout',
    ecommerce: {
      value: cartTotal,                                   // your cart total as a number
      currency: 'USD',
      items: cart.items.map(function (i) {
        return { item_id: i.sku, quantity: i.qty };
      })
    }
  });
});
```

### Order completion (thank-you page)

Place at the bottom of the post-purchase confirmation page:

```html
<script>
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'purchase',
    ecommerce: {
      transaction_id: 'ORDER-123',
      value: 149.00,
      currency: 'USD',
      items: [
        { item_id: 'SKU-1', quantity: 1 },
        { item_id: 'SKU-2', quantity: 2 }
      ]
    }
  });
</script>
```

### Identify (multiple touchpoints)

See [identify-touchpoints.md](../identify-touchpoints.md) for the full list. The short version:

```js
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  event: 'retaint_identify',
  user: { email: 'jane@example.com', phone: '+15551234567', fullName: 'Jane Doe' }
});
```

Push from: signup success, login success, checkout email blur, checkout form submit, newsletter signup.

## SPA navigation

Single-page apps don't reload on navigation, so PDP/category/search pushes need to fire on **route change**, not page load. Hook into your router:

```js
// React Router example
useEffect(() => {
  if (isProductPage(location)) {
    window.dataLayer.push({ event: 'view_item', ecommerce: { items: [product] }});
  }
}, [location]);
```

The `Retaint — Initialize` tag only needs to fire once per real page load — GTM's All Pages trigger handles that for SPAs as long as the GTM snippet itself isn't reinjected on navigation.
