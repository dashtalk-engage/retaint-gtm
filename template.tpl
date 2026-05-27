___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Retaint",
  "brand": {
    "id": "brand_dummy",
    "displayName": "Retaint",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAEMklEQVR4nO2XXWhcRRSAv5m9m26U2BZBSY1pGo3VlFjqk0hLFKl5UCpELCKUIogIir4YERQiKK3VPhQVxYciohKID0KtivahoGn1oU1BY4P2x5+m+cE2RpvNJvtzx4c5d/d63fxqqeD5YLj37JyZc+bMmTN3QVEURVEURVEURVEURVEURVGU/wAGsJfaCUUwiWaBQN7nG5eSthhbABngxsW5uSR7l5QooEk5A/QBRWCn9CUXlRy7JOY6Y1HfBuAocATol+cBoAuoKTviMM5hux2W+8vOrgX2A/uAa2KOW/yCnLRI38kzBTTKsyHhl6kyNvK1Tex9CFwV018SkVO3x4wl2/sA7e0ESSedwwC3xXTXSl886LVU31mA1cC9olONdEw3sn9nzF5TFXuLInJsI1ACpoG78OfyRXx6hjU1tAC8daR5+cfjzW0fnFlz82HXUIvfuZ9Ebxo4BeyWORuAHuk/CTwJvAccBx4TnXeAw8DjIvdIfzfwKvAzMIDPRIBW+a0A5GTeFxJr+RvJnZsNK+1r4A+gF3jGGEw+T9DvWtb/MhTeRwGTCQz5mdrcg10rvunZPbEKSDmHA5qBepnnE3y6RuzB75qhkvIbRKdP5HXATcDzCd9eBn7AB6ORyjG6TuzBHMdgIekRDbbALuAl4F1jSDnHsf3DTVOj50pbbeCmio6cAzfxazh097YrDllLp3PlOe7A7+49srAC8Cw+VZ8GQml5sZcVeUbkSZG/xQfzenkvAQ8DPwIPiK0icCs+O6zIVVloBkQ8Wo6K4aBzPHJlfXrd6FDJ2bSxOC4Y4wZPHM9+3tUxliXNCKXy2BFgArhFFnIK2CF9rwDbJDDRDkZZF989C3wkiwX4VMbUyZzDMd2zwG/Ms8kLyYDIoWngIZm0RIq3gZOnvy+uCtLMWEdtYF1/7ovT+7o6xrLOYSiwLDEeKIdkWWJx6QX4ApVbJO57ZKOavTlZaABK+CuvF9gLpCixC8hc25w6EYZcZiy/h5jNmU3NXT2Dq5uMwQUBBXE4xKd+C/5MW3yVfwOfqq/hb4lSzG4ocpiQHZXj4hI6eSpB3SL24B/WgABfRdP4u3UnMBk66o1hz6b0jr5iwV1wIcsNLmcM6dq61PbPRm5YU1zJoDGckbGv46v3Qfx3hMUfqa/wlb4kdqJrr24WORPzLbpGLxd5ABgTnb34ehWyxFsgSqXz4nBRnBwHnsLRiaHBmK0rv3Rtb46fzW4JAnu1tS5nMKPns4Upc47JdJqOfJ4n8DseVfRO4DmgHZiSwGwE1ssikEANA9/F5LGYDL4IHgCOiTwObMYHtBE4lFjLv8Jf06m7kkUDrrWm17XWzKp78bko9qoVHRv/zTlMt6v0dzusfAlGutExinQMlT9TNtYXr/rzyXP5FlTRVRRFURRFURRFURRFURRFURRF+X/zJ/HTOJkHomfxAAAAAElFTkSuQmCC"
  },
  "description": "Send customer events from your site to Retaint for retention marketing — productview, addtocart, checkout, purchase, identify. Use the Initialize mode once on All Pages, then add Track / Identify / Product Index tags on your dataLayer events.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "tagType",
    "displayName": "Tag Type",
    "macrosInSelect": false,
    "selectItems": [
      { "value": "init",     "displayValue": "Initialize (load Retaint snippet + configure)" },
      { "value": "track",    "displayValue": "Track Event" },
      { "value": "identify", "displayValue": "Identify User" },
      { "value": "index",    "displayValue": "Product Index" }
    ],
    "simpleValueType": true,
    "defaultValue": "init",
    "help": "Pick what this tag should do. Most containers need exactly one Initialize tag (firing on All Pages) plus one or more Track/Identify/Product Index tags."
  },

  {
    "type": "TEXT",
    "name": "orgId",
    "displayName": "Retaint Org ID",
    "simpleValueType": true,
    "valueValidators": [
      { "type": "NON_EMPTY" },
      { "type": "REGEX", "args": ["^[A-Za-z0-9\\-_]{10,64}$"], "errorMessage": "Org ID must be 10–64 characters, letters/numbers/dash/underscore only." }
    ],
    "help": "Paste your Org ID from the Retaint dashboard (Settings → Workspace).",
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "init", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "snippetUrl",
    "displayName": "Snippet URL",
    "simpleValueType": true,
    "defaultValue": "https://tracker.retaint.com/retaint.wl.js",
    "help": "Leave the default unless Retaint support told you otherwise.",
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "init", "type": "EQUALS" }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "waitForConsent",
    "checkboxText": "Wait for consent before loading the Retaint snippet",
    "simpleValueType": true,
    "defaultValue": false,
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "init", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "consentVariable",
    "displayName": "Consent variable",
    "simpleValueType": true,
    "help": "A GTM variable (e.g. {{Marketing Consent}}) that resolves truthy when the visitor has given marketing consent. Snippet load is deferred until then. Leave blank to auto-detect Google Consent Mode v2.",
    "enablingConditions": [
      { "paramName": "tagType",        "paramValue": "init", "type": "EQUALS" },
      { "paramName": "waitForConsent", "paramValue": true,   "type": "EQUALS" }
    ]
  },

  {
    "type": "SELECT",
    "name": "eventName",
    "displayName": "Event name",
    "macrosInSelect": false,
    "selectItems": [
      { "value": "productview",     "displayValue": "productview" },
      { "value": "categoryview",    "displayValue": "categoryview" },
      { "value": "search",          "displayValue": "search" },
      { "value": "addtocart",       "displayValue": "addtocart" },
      { "value": "checkoutstarted", "displayValue": "checkoutstarted" },
      { "value": "buy",             "displayValue": "buy" },
      { "value": "order",           "displayValue": "order" },
      { "value": "custom",          "displayValue": "Custom…" }
    ],
    "simpleValueType": true,
    "defaultValue": "productview",
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "track", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "customEventName",
    "displayName": "Custom event name",
    "simpleValueType": true,
    "valueValidators": [
      { "type": "NON_EMPTY" },
      { "type": "REGEX", "args": ["^[a-z][a-z0-9_]{0,49}$"], "errorMessage": "Lowercase letters/numbers/underscores, must start with a letter, max 50 chars." }
    ],
    "enablingConditions": [
      { "paramName": "tagType",   "paramValue": "track",  "type": "EQUALS" },
      { "paramName": "eventName", "paramValue": "custom", "type": "EQUALS" }
    ]
  },
  {
    "type": "SELECT",
    "name": "valueType",
    "displayName": "Value type",
    "macrosInSelect": false,
    "selectItems": [
      { "value": "string", "displayValue": "String (URL, search term, etc.)" },
      { "value": "array",  "displayValue": "Array of IDs (for 'buy')" },
      { "value": "object", "displayValue": "Object (for 'order', 'checkoutstarted')" }
    ],
    "simpleValueType": true,
    "defaultValue": "string",
    "help": "How is the event value shaped? The default matches the selected event name — only change if you're sending a custom payload.",
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "track", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "valueString",
    "displayName": "Value",
    "simpleValueType": true,
    "help": "The single string value for the event. Typically bound to a Variable like {{CJS - Retaint Product Reference}} or {{Page URL}}.",
    "enablingConditions": [
      { "paramName": "tagType",   "paramValue": "track",  "type": "EQUALS" },
      { "paramName": "valueType", "paramValue": "string", "type": "EQUALS" }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "valueArray",
    "displayName": "Value (array of IDs)",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "ID",
        "name": "id",
        "type": "TEXT",
        "isUnique": false
      }
    ],
    "help": "Each row is one ID. Typically bound to a Custom JS Variable that flattens ecommerce.items[] for the 'buy' event.",
    "enablingConditions": [
      { "paramName": "tagType",   "paramValue": "track", "type": "EQUALS" },
      { "paramName": "valueType", "paramValue": "array", "type": "EQUALS" }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "valueObject",
    "displayName": "Value (key/value pairs)",
    "simpleTableColumns": [
      { "defaultValue": "", "displayName": "Key",   "name": "key",   "type": "TEXT", "isUnique": true },
      { "defaultValue": "", "displayName": "Value", "name": "value", "type": "TEXT", "isUnique": false }
    ],
    "help": "Object payload — e.g. orderId, totalOrderValue, email, phone, fullName for the 'order' event.",
    "enablingConditions": [
      { "paramName": "tagType",   "paramValue": "track",  "type": "EQUALS" },
      { "paramName": "valueType", "paramValue": "object", "type": "EQUALS" }
    ]
  },

  {
    "type": "TEXT",
    "name": "identifyEmail",
    "displayName": "Email",
    "simpleValueType": true,
    "help": "Typically bound to {{DLV - user.email}}.",
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "identify", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "identifyPhone",
    "displayName": "Phone",
    "simpleValueType": true,
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "identify", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "identifyFullName",
    "displayName": "Full name",
    "simpleValueType": true,
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "identify", "type": "EQUALS" }
    ]
  },

  {
    "type": "TEXT",
    "name": "indexProductId",
    "displayName": "Product ID",
    "simpleValueType": true,
    "valueValidators": [{ "type": "NON_EMPTY" }],
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "indexTitle",
    "displayName": "Title",
    "simpleValueType": true,
    "valueValidators": [{ "type": "NON_EMPTY" }],
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "indexCanonicalUrl",
    "displayName": "Canonical URL",
    "simpleValueType": true,
    "valueValidators": [{ "type": "NON_EMPTY" }],
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "indexPrice",
    "displayName": "Price",
    "simpleValueType": true,
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "indexDescription",
    "displayName": "Description",
    "simpleValueType": true,
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "indexImage",
    "displayName": "Image URL",
    "simpleValueType": true,
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },
  {
    "type": "TEXT",
    "name": "indexLanguage",
    "displayName": "Language",
    "simpleValueType": true,
    "help": "Two-letter ISO code. Typically bound to {{Browser Language}}.",
    "enablingConditions": [
      { "paramName": "tagType", "paramValue": "index", "type": "EQUALS" }
    ]
  },

  {
    "type": "CHECKBOX",
    "name": "debug",
    "checkboxText": "Debug logging (console)",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "Logs every call to the browser console. Also enabled globally by setting window.retaintDebug = true."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const setInWindow       = require('setInWindow');
const copyFromWindow    = require('copyFromWindow');
const createQueue       = require('createQueue');
const injectScript      = require('injectScript');
const logToConsole      = require('logToConsole');
const getTimestampMillis = require('getTimestampMillis');
const makeNumber        = require('makeNumber');

const TEMPLATE_VERSION = '1.0.0';

// ---- helpers -------------------------------------------------------------

const debugEnabled = function () {
  return data.debug === true || copyFromWindow('retaintDebug') === true;
};

const log = function () {
  if (!debugEnabled()) return;
  // Convert arguments to an array logToConsole can spread
  const args = ['[Retaint]'];
  for (let i = 0; i < arguments.length; i++) args.push(arguments[i]);
  logToConsole.apply(null, args);
};

const ensureBootstrapGlobals = function () {
  setInWindow('BaseFtObject', 'retaint', false);
  if (!copyFromWindow('retaint.l')) {
    setInWindow('retaint.l', getTimestampMillis(), true);
  }
};

const consentGranted = function () {
  if (!data.waitForConsent) return true;
  if (data.consentVariable !== undefined && data.consentVariable !== '') {
    // GTM resolves the variable before the field reaches us, so we just check truthiness
    return !!data.consentVariable;
  }
  // Auto-detect Google Consent Mode v2: window.google_tag_data.ics.entries.ad_user_data === 'granted'
  const gcm = copyFromWindow('google_tag_data');
  if (gcm && gcm.ics && gcm.ics.entries && gcm.ics.entries.ad_user_data) {
    return gcm.ics.entries.ad_user_data === 'granted';
  }
  return false;
};

const normalizeTrackValue = function () {
  if (data.valueType === 'string') {
    return data.valueString || '';
  }
  if (data.valueType === 'array') {
    const rows = data.valueArray || [];
    const out = [];
    for (let i = 0; i < rows.length; i++) {
      if (rows[i] && rows[i].id !== '' && rows[i].id !== undefined) {
        out.push(rows[i].id);
      }
    }
    return out;
  }
  if (data.valueType === 'object') {
    const rows = data.valueObject || [];
    const out = {};
    for (let i = 0; i < rows.length; i++) {
      const row = rows[i];
      if (row && row.key) {
        // Best-effort numeric coercion for fields that look like numbers (totalOrderValue, itemCount)
        const n = makeNumber(row.value);
        out[row.key] = (n === n && row.value !== '' && row.value !== undefined) ? n : row.value;
      }
    }
    return out;
  }
  return '';
};

const stripEmpty = function (obj) {
  const out = {};
  for (const k in obj) {
    if (obj[k] !== undefined && obj[k] !== null && obj[k] !== '') {
      out[k] = obj[k];
    }
  }
  return out;
};

// ---- mode handlers -------------------------------------------------------

const runInit = function () {
  const orgId = data.orgId;
  const snippetUrl = data.snippetUrl || 'https://tracker.retaint.com/retaint.wl.js';

  if (!orgId) {
    log('init aborted: missing orgId');
    data.gtmOnFailure();
    return;
  }

  ensureBootstrapGlobals();
  setInWindow('retaint.h', snippetUrl, true);

  const retaintQueue = createQueue('retaint');
  retaintQueue('configure', orgId);
  log('init', 'org=' + orgId, 'snippet=' + snippetUrl, 'tpl=' + TEMPLATE_VERSION);

  if (!consentGranted()) {
    log('init: consent not granted, deferring script load');
    data.gtmOnSuccess();
    return;
  }

  injectScript(snippetUrl, data.gtmOnSuccess, data.gtmOnFailure, snippetUrl);
};

const runTrack = function () {
  const eventName = data.eventName === 'custom' ? data.customEventName : data.eventName;
  if (!eventName) {
    log('track aborted: missing eventName');
    data.gtmOnFailure();
    return;
  }
  const value = normalizeTrackValue();
  ensureBootstrapGlobals();
  const retaintQueue = createQueue('retaint');
  retaintQueue('track', eventName, value);
  log('track', 'event=' + eventName, value);
  data.gtmOnSuccess();
};

const runIdentify = function () {
  const traits = stripEmpty({
    email:    data.identifyEmail,
    phone:    data.identifyPhone,
    fullName: data.identifyFullName
  });
  // Identify with no traits is a no-op — bail before pushing
  let hasAny = false;
  for (const _ in traits) { hasAny = true; break; }
  if (!hasAny) {
    log('identify skipped: no traits provided');
    data.gtmOnSuccess();
    return;
  }
  ensureBootstrapGlobals();
  const retaintQueue = createQueue('retaint');
  retaintQueue('identify', traits);
  log('identify', traits);
  data.gtmOnSuccess();
};

const runIndex = function () {
  const product = stripEmpty({
    productId:    data.indexProductId,
    title:        data.indexTitle,
    canonicalUrl: data.indexCanonicalUrl,
    price:        data.indexPrice,
    description:  data.indexDescription,
    image:        data.indexImage,
    language:     data.indexLanguage
  });
  if (!product.productId || !product.title || !product.canonicalUrl) {
    log('index aborted: missing required field');
    data.gtmOnFailure();
    return;
  }
  ensureBootstrapGlobals();
  const retaintQueue = createQueue('retaint');
  retaintQueue('index', product);
  log('index', product);
  data.gtmOnSuccess();
};

// ---- dispatch ------------------------------------------------------------

if (data.tagType === 'init')          runInit();
else if (data.tagType === 'track')    runTrack();
else if (data.tagType === 'identify') runIdentify();
else if (data.tagType === 'index')    runIndex();
else {
  log('unknown tagType:', data.tagType);
  data.gtmOnFailure();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": { "publicId": "inject_script", "versionId": "1" },
      "param": [
        { "key": "urls", "value": { "type": 2, "listItem": [
          { "type": 1, "string": "https://tracker.retaint.com/*" }
        ]}}
      ]
    },
    "clientAnnotations": { "isEditedByUser": true },
    "isRequired": true
  },
  {
    "instance": {
      "key": { "publicId": "access_globals", "versionId": "1" },
      "param": [
        { "key": "keys", "value": { "type": 2, "listItem": [
          { "type": 3, "mapKey": [
            { "type": 1, "string": "key" }, { "type": 1, "string": "read" },
            { "type": 1, "string": "write" }, { "type": 1, "string": "execute" }
          ], "mapValue": [
            { "type": 1, "string": "retaint" }, { "type": 8, "boolean": true },
            { "type": 8, "boolean": true }, { "type": 8, "boolean": true }
          ]},
          { "type": 3, "mapKey": [
            { "type": 1, "string": "key" }, { "type": 1, "string": "read" },
            { "type": 1, "string": "write" }, { "type": 1, "string": "execute" }
          ], "mapValue": [
            { "type": 1, "string": "retaint.l" }, { "type": 8, "boolean": true },
            { "type": 8, "boolean": true }, { "type": 8, "boolean": false }
          ]},
          { "type": 3, "mapKey": [
            { "type": 1, "string": "key" }, { "type": 1, "string": "read" },
            { "type": 1, "string": "write" }, { "type": 1, "string": "execute" }
          ], "mapValue": [
            { "type": 1, "string": "retaint.h" }, { "type": 8, "boolean": true },
            { "type": 8, "boolean": true }, { "type": 8, "boolean": false }
          ]},
          { "type": 3, "mapKey": [
            { "type": 1, "string": "key" }, { "type": 1, "string": "read" },
            { "type": 1, "string": "write" }, { "type": 1, "string": "execute" }
          ], "mapValue": [
            { "type": 1, "string": "BaseFtObject" }, { "type": 8, "boolean": false },
            { "type": 8, "boolean": true }, { "type": 8, "boolean": false }
          ]},
          { "type": 3, "mapKey": [
            { "type": 1, "string": "key" }, { "type": 1, "string": "read" },
            { "type": 1, "string": "write" }, { "type": 1, "string": "execute" }
          ], "mapValue": [
            { "type": 1, "string": "retaintDebug" }, { "type": 8, "boolean": true },
            { "type": 8, "boolean": false }, { "type": 8, "boolean": false }
          ]},
          { "type": 3, "mapKey": [
            { "type": 1, "string": "key" }, { "type": 1, "string": "read" },
            { "type": 1, "string": "write" }, { "type": 1, "string": "execute" }
          ], "mapValue": [
            { "type": 1, "string": "google_tag_data" }, { "type": 8, "boolean": true },
            { "type": 8, "boolean": false }, { "type": 8, "boolean": false }
          ]}
        ]}}
      ]
    },
    "clientAnnotations": { "isEditedByUser": true },
    "isRequired": true
  },
  {
    "instance": {
      "key": { "publicId": "logging", "versionId": "1" },
      "param": [
        { "key": "environments", "value": { "type": 1, "string": "debug" } }
      ]
    },
    "clientAnnotations": { "isEditedByUser": true },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Initialize injects the snippet and queues configure
  code: |-
    const mockData = {
      tagType: 'init',
      orgId: 'ZWW2hX4SxCkJ64cVgyD2g',
      snippetUrl: 'https://tracker.retaint.com/retaint.wl.js',
      waitForConsent: false,
      debug: false
    };
    mock('injectScript', (url, onSuccess) => {
      assertThat(url).isEqualTo('https://tracker.retaint.com/retaint.wl.js');
      onSuccess();
    });
    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();

- name: Initialize defers injection when consent variable is false
  code: |-
    const mockData = {
      tagType: 'init',
      orgId: 'ZWW2hX4SxCkJ64cVgyD2g',
      snippetUrl: 'https://tracker.retaint.com/retaint.wl.js',
      waitForConsent: true,
      consentVariable: false,
      debug: false
    };
    let injected = false;
    mock('injectScript', () => { injected = true; });
    runCode(mockData);
    assertThat(injected).isFalse();
    assertApi('gtmOnSuccess').wasCalled();

- name: Track string event pushes to queue
  code: |-
    const mockData = {
      tagType: 'track',
      eventName: 'addtocart',
      valueType: 'string',
      valueString: 'https://example.com/p/123',
      debug: false
    };
    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();

- name: Track array event flattens SIMPLE_TABLE rows
  code: |-
    const mockData = {
      tagType: 'track',
      eventName: 'buy',
      valueType: 'array',
      valueArray: [{ id: 'sku-1' }, { id: 'sku-2' }, { id: '' }],
      debug: false
    };
    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();

- name: Identify with no traits is a no-op success
  code: |-
    const mockData = { tagType: 'identify', debug: false };
    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();

- name: Identify strips empty fields
  code: |-
    const mockData = {
      tagType: 'identify',
      identifyEmail: 'jane@example.com',
      identifyPhone: '',
      identifyFullName: 'Jane Doe',
      debug: false
    };
    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();

- name: Product Index fails fast on missing required field
  code: |-
    const mockData = {
      tagType: 'index',
      indexProductId: 'sku-1',
      indexTitle: '',
      indexCanonicalUrl: 'https://example.com/p/1',
      debug: false
    };
    runCode(mockData);
    assertApi('gtmOnFailure').wasCalled();


___NOTES___

Retaint for Google Tag Manager — v1.0.0

This is a single tag template with four modes (Initialize / Track Event / Identify User / Product Index).
The Initialize tag should fire once on All Pages (Page View). Track/Identify/Product Index tags fire
on their respective dataLayer events (typically the GA4 ecommerce dataLayer that most sites already emit).

See https://retaint.com/integrations/gtm for the sample container and dataLayer contract.
