library flutter_bkash;

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

typedef PaymentStatus<A, B> = void Function(A status, B data);

class BkashPayment extends StatefulWidget {
  final String amount;
  final String intent;
  final String? refNo;
  final String? currency;
  final String? accessToken;
  final String createBKashUrl;
  final String executeBKashUrl;
  final String scriptUrl;
  final PaymentStatus<String, dynamic> paymentStatus;

  const BkashPayment({
    Key? key,
    required this.amount,
    required this.intent,
    this.refNo,
    this.currency,
    this.accessToken,
    required this.createBKashUrl,
    required this.executeBKashUrl,
    required this.scriptUrl,
    required this.paymentStatus,
  }) : super(key: key);

  @override
  BkashPaymentState createState() => BkashPaymentState();
}

class BkashPaymentState extends State<BkashPayment> {
  InAppWebViewController? webViewController;

  bool isLoading = true;
  var paymentData = {};

  // payment handler as payment status
  void _paymentHandler(status, data) {
    widget.paymentStatus.call(status, data);
  }

  @override
  void initState() {
    super.initState();

    // payment data create as like below
    paymentData = {
      'paymentRequest': {
        'amount': widget.amount, // amount for payment
        'intent': widget.intent, // sale
        'ref_no': widget.refNo ?? '', // order no
        'currency': widget.currency ?? '' // BDT
      },
      'paymentConfig': {
        'createCheckoutURL': widget.createBKashUrl,
        'executeCheckoutURL': widget.executeBKashUrl,
        'scriptUrl': widget.scriptUrl,
      },
      'accessToken': widget.accessToken ?? '',
    };
    // print(paymentData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('bKash Checkout')),
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.pop(context, true),
          ),
          title: const Text('bKash Checkout')),
      body: Stack(
        children: [
          InAppWebView(
            // access the html file on local
            initialFile:
                "packages/flutter_bkash/assets/www/checkout_bkash.html",
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                javaScriptCanOpenWindowsAutomatically: true,
                useShouldInterceptFetchRequest: true,
              ),
              android: AndroidInAppWebViewOptions(
                useShouldInterceptRequest: true,
                useHybridComposition: true,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
              //sending data from dart to js
              controller.addJavaScriptHandler(
                  handlerName: 'paymentData',
                  callback: (args) {
                    // return data to the JavaScript side!
                    return paymentData;
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'accessToken',
                  callback: (args) {
                    // return data to the JavaScript side!
                    return widget.accessToken;
                  });

              controller.clearCache();
            },

            onLoadStop: ((controller, url) {
              // print('url $url');

              // for payment success
              controller.addJavaScriptHandler(
                  handlerName: 'paymentSuccess',
                  callback: (success) {
                    // print("bkashSuccess $success");
                    _paymentHandler('paymentSuccess', success[0]);
                  });

              // for payment failed
              controller.addJavaScriptHandler(
                  handlerName: 'paymentFailed',
                  callback: (failed) {
                    // print("bkashFailed $failed");
                    _paymentHandler('paymentFailed', failed);
                  });

              // for payment error
              controller.addJavaScriptHandler(
                  handlerName: 'paymentError',
                  callback: (error) {
                    // print("paymentError => $error");
                    _paymentHandler('paymentError', error[0]);
                  });

              // for payment failed
              controller.addJavaScriptHandler(
                  handlerName: 'paymentClose',
                  callback: (close) {
                    // print("paymentClose => $close");
                    _paymentHandler('paymentClose', close[0]);
                  });

              setState(() => isLoading = false);
            }),

            onConsoleMessage: (controller, consoleMessage) {
              // for view the console log as message on flutter side
              dev.log(consoleMessage.toString());
            },
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
