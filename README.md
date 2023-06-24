
<p align="center" >
  <img src="https://www.bkash.com/images/favicon.png">
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
    flutter_bkash: ^0.2.0
```
Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more. Import it, Now in your Dart code, you can use:
```
import 'package:flutter_bkash/flutter_bkash.dart';
```
## Features
- Pay using bKash without an agreement
- Create a bKash agreement for future payments
- Pay using bKash with an agreement

## Usage
Official Link for API documentation and demo checkout
- [bKash API Specifications](https://developer.bka.sh/v1.2.0-beta/reference)
- [bKash Payment Checkout Demo](https://merchantdemo.sandbox.bka.sh/frontend/checkout)

### Initialize the `FlutterBkash` instance:

***Sandbox***
```
final flutterBkash = FlutterBkash();
```
***Production*** 
```
final flutterBkash = FlutterBkash(
	credentials: BkashCredentials(
    username: "app_username",
    password: "app_password",
    appKey: "app_key",
    appSecret: "app_secret",
    isSandbox: false,
  ),
);
```
> Make sure to replace the provided credentials with your own bKash sandbox or production credentials depending on your development environment.

### Pay without Agreement
To make a payment without an agreement, use the `pay` method:

***Request***
```
final result = await flutterBkash.pay(
      context: context, // BuildContext context
      amount: 100.0, // amount as double
      merchantInvoiceNumber: "invoice123",
);
```
***Response***
```
BkashPaymentResponse(
	trxId: AFI60BAC94, 
	payerReference:  , 
	paymentId: TR0011fd4uZMS1687062024354, 
	customerMsisdn: 01877722345, 
	merchantInvoiceNumber: tranId, 
	_executeTime: 2023-06-18T10:22:31:623 GMT+0600
)
```
### Create Agreement
To create a new agreement, use the `createAgreement` method:

***Request***
```
final result = await flutterBkash.createAgreement(context: context);
```
***Response***
```
BkashAgreementResponse(
	payerReference:  , 
	paymentId: TR0000RCHQGmX1687063332607, 
	customerMsisdn: 01877722345, 
	agreementId: TokenizedMerchant02P1AIJ7G1687063381235, 
	_executeTime: 2023-06-18T10:43:01:235 GMT+0600
)
```
### Pay with Agreement
To make a payment with an existing agreement, use the `payWithAgreement` method:

***Request***
```
final result = await flutterBkash.payWithAgreement(
  context: context, // BuildContext context
  amount: 100.0, // type as double
  agreementId: "agreement123",
  merchantInvoiceNumber: "invoice123",
);
```
***Response***
```
BkashPaymentResponse(
	trxId: AFI60BAC94, 
	payerReference:  , 
	paymentId: TR0011fd4uZMS1687062024354, 
	customerMsisdn: 01877722345, 
	merchantInvoiceNumber: tranId, 
	_executeTime: 2023-06-18T10:22:31:623 GMT+0600
)
```
### Error Handling
The methods mentioned above may throw a `BkashFailure` exception in case of an error. You can catch and handle the exception using a try-catch block:
```
try {
  // Make a payment or create an agreement
} on BkashFailure catch (e) {
  // Handle the error
  print(e.message);
}
```

Examples for see the `/example` folder.

**Here is the example code** [link](https://github.com/codeboxrcodehub/flutter-bkash/blob/master/example/lib/main.dart)

### Importance Notes
- Read the comments in the example of code
- See the documents and demo checkout [bKash API Specifications](https://developer.bka.sh/v1.2.0-beta/reference), [bKash Payment Checkout Demo](https://merchantdemo.sandbox.bka.sh/frontend/checkout)


## Contributing
**Core Maintainer**
- [Md Riadul Islam](https://github.com/rdnasim)
- [ABDULLAH AL MASUM](https://github.com/dev-masum)

Contributions to the **flutter_bkash** package are welcome. Please note the following guidelines before submitting your pull request.

- Follow [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) coding standards.
- Read bKash API documentations first.Please contact with bKash for their api documentation and sandbox access.

## License

flutter_bkash package is licensed under the [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause).

Copyright 2023 [Codeboxr.com Team](https://codeboxr.com/team-codeboxr/). We are not affiliated with bKash and don't give any guarantee.
