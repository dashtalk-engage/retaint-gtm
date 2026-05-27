# Retaint for Google Tag Manager — Setup

Three ways to install, in order of recommended effort.

## Path 1 — Import the sample container (recommended, ~2 minutes)

The fastest path. Brings in the Retaint custom tag template plus all 10 tags, 8 triggers, and 14 variables pre-wired to the standard GA4 ecommerce dataLayer.

1. In your GTM workspace, go to **Admin → Import Container**.
2. Choose the file `containers/retaint-ecommerce.json` from this repo (or download the [latest release](https://github.com/dashtalk-engage/retaint-gtm/releases)).
3. Pick **Merge** (not Overwrite) and select **Create new versions of conflicting tags** (or merge into an empty workspace).
4. Click **Confirm**.
5. Open **Variables** → find the **Retaint - Org ID** Constant variable → click into it → replace `PASTE_YOUR_ORG_ID_HERE` with your real Org ID → **Save**.
6. **Submit** and **Publish** the workspace.

Verify with the [diagnostic page](https://retaint.com/integrations/gtm/diagnostic) before publishing if you want a smoke-test first.

## Path 2 — Install the template from the GTM Community Template Gallery

For integrators with a heavily-customized container who want to build their own tags around the Retaint template.

1. In your GTM workspace, go to **Templates** → **Tag Templates** → **Search Gallery**.
2. Search for **Retaint** and click into it.
3. Click **Add to workspace** → **Add**.
4. Build your own Tags using the new **Retaint** template — see [datalayer-contract.md](datalayer-contract.md) for what each Tag Type does.

## Path 3 — Import the `.tpl` file manually

For pre-gallery use, version pinning, or fully air-gapped workspaces.

1. Download `template.tpl` from this repo.
2. In your GTM workspace: **Templates → Tag Templates → New → ⋮ menu → Import**.
3. Select `template.tpl` → **Save**.
4. Build your own Tags around it.

## After installing — your first dataLayer event

The container ships triggers for the standard GA4 ecommerce events. To smoke-test that the wiring works, push a `view_item` event from your browser console on any page:

```js
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  event: 'view_item',
  ecommerce: {
    items: [{
      item_id: 'test-sku-1',
      item_name: 'Test Product',
      price: 19.99,
      item_url: 'https://your-site.example.com/products/test-sku-1'
    }]
  }
});
```

In **GTM Preview Mode**, you should see:
- `Retaint — Product Index` fires (with the product data)
- `Retaint — Product View` fires (with the resolved product URL)

In your Retaint dashboard, the event should arrive within seconds.

## Verify with the diagnostic page

Before going live, visit [retaint.com/integrations/gtm/diagnostic](https://retaint.com/integrations/gtm/diagnostic), paste your Org ID, and click **Run diagnostic**. It checks four things end-to-end: Org ID format, snippet loads, test event accepted, `BASE_LEARNER_ID` cookie set. Everything green = your network can talk to Retaint.

## Reference

- [datalayer-contract.md](datalayer-contract.md) — exactly what to push for each of the 7 dataLayer events Retaint listens for
- [identify-touchpoints.md](identify-touchpoints.md) — when and where to push `retaint_identify`
- [integrations/shopify.md](integrations/shopify.md), [bigcommerce.md](integrations/bigcommerce.md), [woocommerce.md](integrations/woocommerce.md), [generic-js.md](integrations/generic-js.md) — copy-paste snippets per platform

## Coexistence with the WordPress plugin

If your site runs both [Retaint for WordPress](https://github.com/tryumbrelladev/retaint-wp) and this GTM kit, **every event will fire twice**. Pick one:

- Vanilla WooCommerce → use the WordPress plugin
- Custom site, headless commerce, or anything non-WordPress → use this GTM kit
- Hybrid (rare) → see [integrations/woocommerce.md](integrations/woocommerce.md) for how to disable browsing events on the WP side and keep order/identify on the GTM side
