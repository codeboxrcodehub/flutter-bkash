<p align="center" >
  <img src="https://www.bkash.com/sites/all/themes/bkash/logo.png?87980">
</p>

 <h1 align="center">bKash(BD) Mobile Finance Payment Gateway for Flutter</h1>
<p align="center" >

[//]: # (<img src="#" />)
[//]: # (<img src="#" />)

</p>

[![Pub](https://img.shields.io/pub/v/flutter_bkash.svg)](https://pub.dartlang.org/packages/flutter_bkash)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]()  [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]() 
[![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

This is a Flutter package for [bKash](https://www.bkash.com/) BD Payment Gateway. This package can be used in flutter project. We created this package while working for a project and thought to made it release for all so that it helps.

## How to use:

Depend on it, Run this command With Flutter:

```
$ flutter pub add flutter_bkash
```

This will add a line like this to your package's `pubspec.yaml` (and run an implicit **`flutter pub get`**):

```
dependencies:
    flutter_bkash: ^0.1.0
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.
Import it

Now in your Dart code, you can use:

`
import 'package:flutter_bkash/flutter_bkash.dart';
`

## Usage
examples for see the `/example` folder.

**Here is the example code**
```
BkashPayment(  
    // amount of your bkash payment  
    amount: '20',  
    // intent would be (sale / authorization)  
    intent: 'sale',  
    // accessToken: '', // if the user have own access token for verify payment  
    // currency: 'BDT', // bkash url for create payment, when you implement on you project then it be change as your production create url  
    createBKashUrl: 'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',  
    // bkash url for execute payment, , when you implement on you project then it be change as your production create url  
    executeBKashUrl: 'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',  
    // for script url, when you implement on production the set it live script js  
    scriptUrl: 'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',  
      
    // the return value from the package  
    // status => 'paymentSuccess', 'paymentFailed', 'paymentError', 'paymentClose' // data => return value of response  
    paymentStatus: (status, data) {  
    dev.log('return status => $status');  
    dev.log('return data => $data');

    // when payment success  
    if (status == 'paymentSuccess') {
        if (data['transactionStatus'] == 'Completed') {
            Style.basicToast('Payment Success');  
        }
    }  
      
    // when payment failed  
    else if (status == 'paymentFailed') {
        if (data.isEmpty) {
            Style.errorToast('Payment Failed');
        } else if (data[0]['errorMessage'].toString() != 'null'){
            Style.errorToast("Payment Failed ${data[0]['errorMessage']}");
        } else {  
            Style.errorToast("Payment Failed");
        }
    }  
      
    // when payment on error  
    else if (status == 'paymentError') {
        Style.errorToast(jsonDecode(data['responseText'])['error']);
    }  
      
    // when payment close on demand closed the windows  
    else if (status == 'paymentClose') {
        if (data == 'closedWindow') {
            Style.errorToast('Failed to payment, closed screen');
        } else if (data == 'scriptLoadedFailed') {
            Style.errorToast('Payment screen loading failed');
        }
    }
    // back to screen to pop()
    Navigator.of(context).pop();
    },
)
```

### Importance Notes
- Read the comments in the example of code
- **intent** - it would be 'sale' or 'authorization'
- Payment status return as 'paymentSuccess', 'paymentFailed', 'paymentError', 'paymentClose', find on this keyword of the payment status, then you get the data of response on specific status.
