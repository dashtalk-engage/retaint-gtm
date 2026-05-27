# Retaint for Google Tag Manager

Drop-in Google Tag Manager integration for [Retaint](https://retaint.com) — retention marketing for any website. Loads the Retaint tracker, captures the standard ecommerce events (productview, addtocart, checkout, purchase) from your existing GA4 dataLayer, and stitches anonymous browsing to known customers via `retaint_identify`.

Ships as both a **custom tag template** (`.tpl` for installation from the GTM Community Template Gallery or via manual import) and a **sample container JSON** with all the tags, triggers, and variables pre-wired so you can be live in two minutes.

The GTM counterpart to [`retaint-wp`](https://github.com/tryumbrelladev/retaint-wp) — same wire protocol, same events, but for any website (Shopify, BigCommerce, custom storefronts, headless commerce).

## Quick start

1. Download `containers/retaint-ecommerce.json` from [the latest release](https://github.com/dashtalk-engage/retaint-gtm/releases).
2. In your GTM workspace: **Admin → Import Container**, choose the file, pick **Merge**.
3. Open the **Retaint - Org ID** Constant variable, paste your Org ID, save.
4. **Submit** and **Publish**.

Full setup guide → [`docs/README.md`](docs/README.md).
Verify connectivity → [retaint.com/integrations/gtm/diagnostic](https://retaint.com/integrations/gtm/diagnostic).

## What's in the box

| | |
|---|---|
| `template.tpl` | Custom tag template with four modes: Initialize, Track Event, Identify User, Product Index |
| `containers/retaint-ecommerce.json` | Sample container — 10 tags, 8 triggers, 14 variables, ready to import |
| `containers/retaint-ecommerce.source.json` | Source for the container (template inlined at build time) |
| `tools/build-container.py` | Inlines `template.tpl` into the source container to produce the final JSON |
| `diagnostic/index.html` | Standalone connectivity verifier deployed to `retaint.com/integrations/gtm/diagnostic` |
| `docs/` | Setup guide, dataLayer event contract, identify touchpoints, per-platform integrations |
| `metadata.yaml` | GTM Community Template Gallery submission metadata |

## Events supported

| dataLayer event | Retaint call |
|---|---|
| `view_item` | `index({...})` + `track('productview', productRef)` |
| `view_item_list` | `track('categoryview', pageUrl)` |
| `search` | `track('search', searchTerm)` |
| `add_to_cart` | `track('addtocart', productRef)` |
| `begin_checkout` | `track('checkoutstarted', {...})` |
| `purchase` | `track('buy', [ids])` + `track('order', {...})` |
| `retaint_identify` | `identify({email, phone, fullName})` |

Full payload schemas in [`docs/datalayer-contract.md`](docs/datalayer-contract.md).

## Development

To regenerate `containers/retaint-ecommerce.json` after editing `template.tpl`:

```sh
python3 tools/build-container.py
```

To run the sandbox unit tests, import `template.tpl` into a GTM workspace and run the tests from the Template Editor (the `___TESTS___` section is automatically picked up by GTM's built-in test runner).

## Coexistence with the WordPress plugin

If you're on WooCommerce, use [`retaint-wp`](https://github.com/tryumbrelladev/retaint-wp) — it does everything this kit does, plus server-side identity capture from WP/WC accounts. Running both fires every event twice. See [`docs/integrations/woocommerce.md`](docs/integrations/woocommerce.md) for hybrid setups.

## License

GPLv2 or later. See [`LICENSE`](LICENSE).
