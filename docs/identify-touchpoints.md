# When to push `retaint_identify`

The container has one trigger (`retaint_identify`), but you should push that event from **every touchpoint where the visitor's identity becomes known**. Each push links the anonymous browsing cookie (`BASE_LEARNER_ID`) to a known email/phone — so retention campaigns can target them.

> **Identify early, identify often.** It's idempotent; pushing the same identity twice has no side effects, but missing a single touchpoint means a customer's pre-login browsing never gets stitched to their account.

## Standard touchpoints

| When | Why |
|---|---|
| **Account sign-up** succeeds | Earliest possible stitch — captures pre-signup browsing |
| **Login** succeeds | Re-stitches returning visitors using a new device/browser |
| Checkout — **email field blur** with a valid value | Captures email even if checkout is later abandoned |
| Checkout — **form submit** (before navigation) | Last-chance capture if blur didn't fire |
| **Newsletter signup** form submit | Standalone identity capture, no purchase needed |
| Any flow that asks for email/phone | Same idea: capture as soon as it's known |

## Copy-paste snippets

### After successful login or signup

```js
// In your auth success handler (after your API returns the user object):
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  event: 'retaint_identify',
  user: {
    email: user.email,
    phone: user.phone,         // optional
    fullName: user.fullName    // optional
  }
});
```

### On checkout email field blur

```js
document.querySelector('input[name="email"]').addEventListener('blur', function (e) {
  var email = e.target.value.trim();
  if (!email || !/.+@.+\..+/.test(email)) return;
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'retaint_identify',
    user: { email: email }
  });
});
```

### On checkout form submit

```js
document.querySelector('form#checkout').addEventListener('submit', function (e) {
  var form = e.target;
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({
    event: 'retaint_identify',
    user: {
      email:    form.email.value,
      phone:    form.phone && form.phone.value,
      fullName: (form.first_name.value + ' ' + form.last_name.value).trim()
    }
  });
});
```

### On newsletter signup

```js
document.querySelector('form.newsletter').addEventListener('submit', function (e) {
  var email = e.target.querySelector('input[type=email]').value.trim();
  if (!email) return;
  window.dataLayer = window.dataLayer || [];
  window.dataLayer.push({ event: 'retaint_identify', user: { email: email } });
});
```

## Common mistakes

- **Pushing only on purchase.** That misses every pre-purchase touchpoint — newsletter signups, abandoned carts, account-only signups, etc. Push on each touchpoint.
- **Pushing only on the form submit, not on blur.** If a user types their email into checkout then bounces, you've lost the cart-recovery opportunity. The blur push fires first; the submit push is a safety net.
- **Pushing empty strings.** Empty `email` / `phone` / `fullName` values are stripped before the network call, so it's harmless — but it adds noise to your debug logs. Validate before pushing.
- **Pushing the same identity on every page load.** Identify on the *event* (login, blur, submit), not on every pageview. Most sites accidentally re-identify on every page because they hydrate the user into the dataLayer on every render — push only when the identity is newly available.

## What Retaint does with the data

Each `retaint_identify` call sends `{ userId: BASE_LEARNER_ID, email, phone, fullName, language }` to `https://tracker.retaint.com/rest/v1/learn/identify`. Retaint joins the anonymous `userId` to the known email/phone, so future events from the same browser are attributed to the right customer in your retention campaigns.
