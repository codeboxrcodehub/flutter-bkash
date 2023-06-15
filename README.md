<p align="center" >
  <img src="https://www.bkash.com/sites/all/themes/bkash/logo.png?87980">
</p>

 <h1 align="center">bKash(BD) Mobile Finance Payment Gateway Flutter Package</h1>
<p align="center" >

</p>

[![Pub](https://img.shields.io/pub/v/flutter_bkash.svg)](https://pub.dartlang.org/packages/flutter_bkash)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]()  [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]() 
[![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

This is a [Flutter package](https://pub.dartlang.org/packages/flutter_bkash) for [bKash](https://www.bkash.com/) BD Payment Gateway. This package can be used in flutter project. We created this package while working for a project and thought to release for all so that it helps.

> :warning: Please note that, you have to contact with bKash sales team for any kind of dev or production access keys or tokens. We don't provide any test account or access keys or don't contact us for such

Check the package in <a target="_blank" href="https://github.com/codeboxrcodehub/flutter-bkash" rel="noopener">github</a> and also available in <a href="https://pub.dartlang.org/packages/flutter_bkash" rel="noopener nofollow" target="_blank">flutter/dart package</a>
## How to use:

Depend on it, Run this command With Flutter:

```
$ flutter pub add flutter_bkash
```

This will add a line like this to your package's `pubspec.yaml` (and run an implicit **`flutter pub get`**):

```
dependencies:
    flutter_bkash: ^1.0.0
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.
Import it

Now in your Dart code, you can use:

`
import 'package:flutter_bkash/flutter_bkash.dart';
`

## Usage

Official Link for API documentation and demo checkout
- [bKash API Specifications](https://developer.bka.sh/v1.2.0-beta/reference)
- [bKash Payment Checkout Demo](https://merchantdemo.sandbox.bka.sh/frontend/checkout)

Examples for see the `/example` folder.

**Here is the example code**
```
final flutterBkash = FlutterBkash();

try {
  final bkashPaymentResponse = await flutterBkash.pay(
    context: context,
    amount: double.parse(amount),
    marchentInvoiceNumber: "tranId",
  );

  print(bkashPaymentResponse);
} on BkashFailure catch (e, st) {
  print(e.message, error: e, stackTrace: st);
} catch (e) {
  print("Something went wrong");
}
```

### Importance Notes
- Read the comments in the example of code
- See the documents and demo checkout [bKash API Specifications](https://developer.bka.sh/v1.2.0-beta/reference), [bKash Payment Checkout Demo](https://merchantdemo.sandbox.bka.sh/frontend/checkout)
<!-- - **intent** - it would be 'sale' or 'authorization' -->
<!-- - Payment status return as 'paymentSuccess', 'paymentFailed', 'paymentError', 'paymentClose', find on this keyword of the payment status, then you get the data of response on specific status. -->


## Contributing

Contributions to the **flutter_bkash** package are welcome. Please note the following guidelines before submitting your pull request.

- Follow [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) coding standards.
- Read bKash API documentations first.Please contact with bKash for their api documentation and sandbox access.

## License

flutter_bkash package is licensed under the [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause).

Copyright 2022 [Codeboxr.com Team](https://codeboxr.com/team-codeboxr/). We are not affiliated with bKash and don't give any guarantee.
