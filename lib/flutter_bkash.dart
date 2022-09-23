library flutter_bkash;

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bkash/src/constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

typedef PaymentStatus<A, B> = void Function(A status, B data);

class BkashPayment extends StatefulWidget {
  /// default the sandbox is true
  final bool isSandbox;

  /// amount of the payment through bKash
  final String amount;

  /// intent as sale or authorization
  final String intent;

  /// reference no is order no or any other unique string for payment
  final String? refNo;

  /// BDT
  final String? currency;

  /// if the user have own access token for verify payment
  final String? accessToken;

  /// create bkash url based on sandbox or production
  final String createBKashUrl;

  /// execute bkash url based on sandbox or production
  final String executeBKashUrl;

  /// javascript script url for load modal window for bkash payment
  final String scriptUrl;

  /// return the payment status
  final PaymentStatus<String, dynamic> paymentStatus;

  const BkashPayment({
    Key? key,
    required this.isSandbox,
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
  // define the payment empty dynamic variable for payment data
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
        'amount': widget.amount,
        'intent': widget.intent,
        'ref_no': widget.refNo ?? '',
        'currency': widget.currency ?? '',
      },
      'paymentConfig': {
        /// sandbox is sandbox or live mode, change the value depend on it
        'createCheckoutURL': widget.isSandbox
            ? BkashConstants.sandboxCreateUrlBKash
            : widget.createBKashUrl,
        'executeCheckoutURL': widget.isSandbox
            ? BkashConstants.sandboxExecuteUrlBKash
            : widget.executeBKashUrl,
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
          backgroundColor: Colors.pink,
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
              //sending data from dart to js the data of payment
              controller.addJavaScriptHandler(
                  handlerName: 'paymentData',
                  callback: (args) {
                    // return data to the JavaScript side!
                    return paymentData;
                  });
              controller.clearCache();
            },

            onLoadStop: ((controller, url) {
              // print('url $url');

              /// for payment success
              controller.addJavaScriptHandler(
                  handlerName: 'paymentSuccess',
                  callback: (success) {
                    // print("bkashSuccess $success");
                    _paymentHandler('paymentSuccess', success[0]);
                  });

              /// for payment failed
              controller.addJavaScriptHandler(
                  handlerName: 'paymentFailed',
                  callback: (failed) {
                    // print("bkashFailed $failed");
                    _paymentHandler('paymentFailed', failed);
                  });

              /// for payment error
              controller.addJavaScriptHandler(
                  handlerName: 'paymentError',
                  callback: (error) {
                    // print("paymentError => $error");
                    _paymentHandler('paymentError', error[0]);
                  });

              /// for payment failed
              controller.addJavaScriptHandler(
                  handlerName: 'paymentClose',
                  callback: (close) {
                    // print("paymentClose => $close");
                    _paymentHandler('paymentClose', close[0]);
                  });

              /// set state is loading or not loading depend on page data
              setState(() => isLoading = false);
            }),

            onConsoleMessage: (controller, consoleMessage) {
              /// for view the console log as message on flutter side
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
