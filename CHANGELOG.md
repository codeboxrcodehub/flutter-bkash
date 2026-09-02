## 0.1.0
* initial release.

## 0.1.1
* Modified the readme file
* Added code example on more details view
* Pass static analysis
* Support up-to-date dependencies

## 0.1.2
* Changed the parameter of BkashPayment
* Added to as isSandbox is true/false
* Modified the README.md and example of code more comment also style of formatting. 

## 0.1.3
* Modified the README.md
* Flutter formats the code [flutter format .]

## 0.2.0
* Modified the README.md
* Added Tokenized API feature
* Changed API of flutter Bkash
* Added some feature
  * Pay using bKash without an agreement
  * Create a bKash agreement for future payments
  * Pay using bKash with an agreement

## 0.3.0
* Modified as per new version of bKash API
* Added minor code changes
* Added tokenized api changes

## 0.3.1
* Changed documentation

## 1.0.0
* Added Refund API: `FlutterBkash.refund()` and `FlutterBkash.refundStatus()`
* `refund()` requires `sku` and `reason` — bKash's docs list them as optional, but the sandbox rejects the request without them
* `BkashFailure.message` now surfaces bKash's actual error text (e.g. `errorMessage`/`errorMessageEn` from the response body) instead of a generic status-code message, wherever the API returns one
* Fixed example app failing to build against current Flutter/Gradle/JDK (Gradle 8.14, AGP 8.11.1, Kotlin 2.2.20, upgraded `webview_flutter_android`)
* Redesigned example app: Material 3 UI, on-device History (payments/agreements/refunds persist locally with copy-to-clipboard and chained follow-up actions), and a Sandbox Info page with bKash's test wallet numbers/OTP/PIN
* Declaring 1.0.0: the public API (`FlutterBkash`, `BkashCredentials`, `BkashFailure`, `BkashApi`) is considered stable going forward

## 1.0.1
* Replaced the README's demo video with a gif (`assets/scrcpy_XPL1oS5xdi.gif`) — videos don't render on pub.dev
* Fixed the README header favicon and demo gif to use GitHub raw URLs (`?raw=true`) so both render on pub.dev, not just GitHub
