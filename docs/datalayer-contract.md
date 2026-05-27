# dataLayer Event Contract

The sample container listens for **6 standard GA4 ecommerce dataLayer events** plus **1 Retaint-namespaced identify event**. Most ecommerce platforms (Shopify, BigCommerce, WooCommerce) already emit the GA4 events through their native GA4 connectors — so on those sites you only need to add the `retaint_identify` push yourself.

## Quick reference

| You push | Container fires | Retaint receives |
|---|---|---|
| (page load — no event needed) | `Retaint — Initialize` | `retaint('configure', orgId)` then loads `retaint.wl.js` |
| `view_item` | `Retaint — Product Index` + `Retaint — Product View` | `retaint('index', {...})` + `retaint('track', 'productview', productRef)` |
| `view_item_list` | `Retaint — Category View` | `retaint('track', 'categoryview', pageUrl)` |
| `search` | `Retaint — Search` | `retaint('track', 'search', searchTerm)` |
| `add_to_cart` | `Retaint — Add to Cart` | `retaint('track', 'addtocart', productRef)` |
| `begin_checkout` | `Retaint — Checkout Started` | `retaint('track', 'checkoutstarted', {...})` |
| `purchase` | `Retaint — Buy` + `Retaint — Order` | `retaint('track', 'buy', [ids])` + `retaint('track', 'order', {...})` |
| `retaint_identify` | `Retaint — Identify` | `retaint('identify', {...})` |

All tags fire async and independent. On `view_item` and `purchase`, two tags fire from the same dataLayer event — the Retaint snippet serializes them in queue order.

## Event payloads

### `view_item` — fired on product detail pages

```js
dataLayer.push({
  event: 'view_item',
  ecommerce: {
    items: [{
      item_id: 'sku-123',                                         // REQUIRED — used for productId
      item_name: 'Linen Shirt',                                   // REQUIRED — used for title
      price: 49.00,
      item_url: 'https://example.com/products/linen-shirt',       // OPTIONAL — preferred productRef
      image_url: 'https://cdn.example.com/p/sku-123.jpg',
      item_category: 'shirts',
      item_brand: 'Retaint Apparel'
    }]
  }
});
```

The container reads `items[0]` only — push one item per `view_item` event (the GA4 spec allows arrays, but for PDPs there's only ever one item being viewed).

### `view_item_list` — fired on category and collection pages

```js
dataLayer.push({
  event: 'view_item_list',
  ecommerce: { item_list_name: 'Shirts' }
});
```

Only the event name is required. Retaint receives the Page URL as `eventVal`.

### `search` — fired on search results pages

```js
dataLayer.push({
  event: 'search',
  search_term: 'linen shirt'
});
```

### `add_to_cart` — fired on add-to-cart button click

```js
dataLayer.push({
  event: 'add_to_cart',
  ecommerce: {
    items: [{
      item_id: 'sku-123',
      quantity: 1,
      item_url: 'https://example.com/products/linen-shirt'   // OPTIONAL — preferred productRef
    }]
  }
});
```

The container resolves `eventVal` via this fallback chain (CJS variable `Retaint Product Reference`):
1. `ecommerce.items[0].item_url`
2. `ecommerce.items[0].item_id`
3. `{{Page URL}}`

### `begin_checkout` — fired on checkout button click (after form filled)

```js
dataLayer.push({
  event: 'begin_checkout',
  ecommerce: {
    value: 149.00,
    currency: 'USD',
    items: [
      { item_id: 'sku-123', quantity: 1 },
      { item_id: 'sku-456', quantity: 2 }
    ]
  }
});
```

The container builds `{ pageUrl, totalOrderValue, itemCount, items: [{productId, quantity}] }` from this.

### `purchase` — fired on order completion (thank-you page)

```js
dataLayer.push({
  event: 'purchase',
  ecommerce: {
    transaction_id: 'order-7788',
    value: 149.00,
    currency: 'USD',
    items: [
      { item_id: 'sku-123', quantity: 1 },
      { item_id: 'sku-456', quantity: 2 }
    ]
  }
});
```

Two tags fire on `purchase`:
- **Buy** sends `['sku-123', 'sku-456']` as `eventVal`
- **Order** sends `{ orderId: 'order-7788', totalOrderValue: '149' }` as `eventVal`

Both are independent — no ordering dependency.

### `retaint_identify` — fired wherever email/phone becomes known

```js
dataLayer.push({
  event: 'retaint_identify',
  user: {
    email: 'jane@example.com',
    phone: '+15551234567',
    fullName: 'Jane Doe'
  }
});
```

Nested under `user.` to mirror GA4's `user_properties` convention. All three fields are optional; empty values are stripped before the network call. See [identify-touchpoints.md](identify-touchpoints.md) for where to push this from.

## Custom events

If you need to fire a Retaint event that isn't in the standard set, add a new Tag in your GTM workspace:

1. **New Tag** → choose the **Retaint** template
2. Tag Type: **Track Event**
3. Event name: **Custom…**
4. Custom event name: your event name (lowercase, letters/numbers/underscores, max 50 chars)
5. Set the value via Variables
6. Pick or create a trigger that fires it

Custom events arrive at Retaint with `eventCategory: EXTERNAL` and your chosen `eventName`.
