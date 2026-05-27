# WooCommerce Integration (Coexistence Guide)

For vanilla WooCommerce, the [Retaint WordPress plugin](https://github.com/tryumbrelladev/retaint-wp) is the right answer — it handles every event server-side, captures identity from WP user accounts and order billing, and needs no GTM at all.

This guide is **only for the edge case** where you want to run both:

- The WP plugin for the events it does well (server-side `order`, `buy`, `identify` from WP/WC accounts)
- The GTM kit for events the WP plugin can't see (custom events, non-WC pages, third-party form submissions, etc.)

If that's not you, **uninstall one and stop reading**.

## The double-fire problem

Out of the box, both layers fire the same events:

| Event | WP plugin fires | GTM kit fires |
|---|---|---|
| productview | ✅ on `is_product()` page | ✅ on `view_item` dataLayer |
| categoryview | ✅ on `is_product_category()` | ✅ on `view_item_list` dataLayer |
| search | ✅ on `is_search()` (product results) | ✅ on `search` dataLayer |
| addtocart | ✅ on `woocommerce_add_to_cart` | ✅ on `add_to_cart` dataLayer |
| checkoutstarted | ✅ on `is_checkout()` | ✅ on `begin_checkout` dataLayer |
| buy | ✅ on `woocommerce_thankyou` | ✅ on `purchase` dataLayer |
| order | ✅ on `woocommerce_thankyou` | ✅ on `purchase` dataLayer |
| identify | ✅ on login/register/order | ✅ on `retaint_identify` dataLayer |

Every event lands twice in your Retaint dashboard — bad for analytics, bad for campaign triggers (e.g., abandoned-cart emails firing twice).

## Recommended split

If you must run both, give each layer a non-overlapping job:

### Option A — WP plugin owns commerce, GTM owns the rest

- WP plugin handles: `productview`, `categoryview`, `search`, `addtocart`, `checkoutstarted`, `buy`, `order`, `identify` (from WP/WC accounts)
- GTM kit handles: only custom events (newsletter signups, non-WC form submissions, blog engagement, etc.)
- **Action:** in your GTM workspace, *delete* every tag in the `Retaint` folder *except* `Retaint — Initialize` (and any custom tags you've added). The Initialize tag is still needed if you want the JS snippet to be GTM-managed instead of WP-managed; otherwise delete it too.
- **Caveat:** the WP plugin auto-injects the snippet via `wp_head`, so if both Initialize tags fire you'll load the snippet twice. Pick one source for the snippet.

### Option B — GTM owns everything, WP plugin is disabled

- Deactivate the WP plugin entirely.
- The GTM kit handles all events as documented in [datalayer-contract.md](../datalayer-contract.md).
- Your WC theme or a custom plugin must push the GA4 ecommerce dataLayer events. WooCommerce doesn't do this natively — install a GA4 dataLayer plugin (e.g., GTM4WP, GA Google Analytics with ecommerce, or your own snippets).

### Option C — Suppress browsing events on the WP side

Coming in a future `retaint-wp` release: detect `window.RETAINT_GTM_PRESENT === true` on the front-end and skip injecting the WP snippet's per-page event calls. Tracked in [retaint-wp issue (TBD)]. Until then, use Option A or B.

## Verify

After choosing a split, fire each event manually and confirm **exactly one** copy arrives in your Retaint dashboard per real user action. The [diagnostic page](https://retaint.com/integrations/gtm/diagnostic) only verifies connectivity — it doesn't catch double-fires.
