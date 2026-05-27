# Changelog

All notable changes to Retaint for Google Tag Manager are documented here. Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), versioning follows [SemVer](https://semver.org/spec/v2.0.0.html).

## [1.0.0] — 2026-05-27

Initial release.

### Added
- Single custom tag template (`template.tpl`) with four modes:
  - **Initialize** — loads the Retaint snippet and calls `configure(orgId)`
  - **Track Event** — `retaint('track', eventName, eventVal)` with string / array / object value types
  - **Identify User** — `retaint('identify', { email, phone, fullName })` with empty-field stripping
  - **Product Index** — `retaint('index', productData)` with required-field validation
- Sample container (`containers/retaint-ecommerce.json`) pre-wired to the GA4 ecommerce dataLayer:
  - 10 tags, 8 triggers, 14 variables (9 DLVs, 4 CJS, 1 Constant), all grouped in a `Retaint` folder
  - Listens for `view_item`, `view_item_list`, `search`, `add_to_cart`, `begin_checkout`, `purchase`, and `retaint_identify`
- Standalone diagnostic page (`diagnostic/index.html`) that verifies Org ID format, snippet load, test event acceptance, and `BASE_LEARNER_ID` cookie set
- Optional consent gating via Google Consent Mode v2 or a custom GTM variable
- Global debug override via `window.retaintDebug = true`
- Build script (`tools/build-container.py`) that inlines `template.tpl` into the container at release time
- Per-platform integration docs: Shopify, BigCommerce, WooCommerce (coexistence), generic JS
- Sandboxed JS unit tests embedded in `template.tpl` `___TESTS___` section
