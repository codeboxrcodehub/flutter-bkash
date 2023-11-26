import 'package:flutter/material.dart';
import 'package:flutter_bkash/src/bkash_payment_status.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef PaymentStatus = void Function(BkashPaymentStatus bkashPaymentStatus);

class FlutterBkashView extends StatefulWidget {
  final String bkashURL;
  final String successCallbackURL;
  final String failureCallbackURL;
  final String cancelledCallbackURL;

  const FlutterBkashView({
    Key? key,
    required this.bkashURL,
    required this.successCallbackURL,
    required this.failureCallbackURL,
    required this.cancelledCallbackURL,
  }) : super(key: key);

  @override
  FlutterBkashViewState createState() => FlutterBkashViewState();
}

class FlutterBkashViewState extends State<FlutterBkashView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) {
          //   log(progress.toString());
          // },
          // onPageStarted: (String url) {},
          // onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) =>
              Navigator.of(context).pop(BkashPaymentStatus.failed),
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("bkash.com")) {
              //sendbox starts with sandbox.payment.bkash.com and live starts with payment.bkash.com
              return NavigationDecision.navigate;
            }
            if (request.url.startsWith(widget.successCallbackURL)) {
              Navigator.of(context).pop(BkashPaymentStatus.successed);
            } else if (request.url.startsWith(widget.failureCallbackURL)) {
              Navigator.of(context).pop(BkashPaymentStatus.failed);
            } else if (request.url.startsWith(widget.cancelledCallbackURL)) {
              Navigator.of(context).pop(BkashPaymentStatus.canceled);
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bkashURL));
  }

  @override
  void dispose() {
    _webViewController.clearCache();
    _webViewController.clearLocalStorage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          await _webViewController.goBack();
        }

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.pink,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () =>
                  Navigator.of(context).pop(BkashPaymentStatus.canceled),
            ),
            title: const Text('bKash Checkout')),
        body: WebViewWidget(controller: _webViewController),
      ),
    );
  }

  void showSnackBar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
