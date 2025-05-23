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
    super.key,
    required this.bkashURL,
    required this.successCallbackURL,
    required this.failureCallbackURL,
    required this.cancelledCallbackURL,
  });

  @override
  State<FlutterBkashView> createState() => _FlutterBkashViewState();
}

class _FlutterBkashViewState extends State<FlutterBkashView> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    try {
      final uri = Uri.parse(widget.bkashURL);

      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onWebResourceError: (WebResourceError error) {
              debugPrint("WebView error: ${error.description}, type: ${error.errorType}, code: ${error.errorCode}");
              showSnackBar("ইন্টারনেট সংযোগে সমস্যা হচ্ছে। অনুগ্রহ করে আবার চেষ্টা করুন।");
              // Navigator.of(context).pop(BkashPaymentStatus.failed);
            },
            onNavigationRequest: (NavigationRequest request) {
              debugPrint("Navigation URL: ${request.url}");
              if (request.url.startsWith(widget.successCallbackURL)) {
                Navigator.of(context).pop(BkashPaymentStatus.successed);
                return NavigationDecision.prevent;
              } else if (request.url.startsWith(widget.failureCallbackURL)) {
                Navigator.of(context).pop(BkashPaymentStatus.failed);
                return NavigationDecision.prevent;
              } else if (request.url.startsWith(widget.cancelledCallbackURL)) {
                Navigator.of(context).pop(BkashPaymentStatus.canceled);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(uri);
    } catch (e) {
      debugPrint("❌ Invalid bKash URL: ${widget.bkashURL}");
      Future.delayed(Duration.zero, () {
        showSnackBar("bKash পেমেন্ট লোড করা যায়নি।");
        Navigator.of(context).pop(BkashPaymentStatus.failed);
      });
    }
  }

  @override
  void dispose() {
    _webViewController.clearCache();
    _webViewController.clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
          } else {
            if (context.mounted) {
              Navigator.of(context).pop(BkashPaymentStatus.canceled);
            }
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(BkashPaymentStatus.canceled),
          ),
          title: const Text('bKash Checkout', style: TextStyle(color: Colors.white)),
        ),
        body: WebViewWidget(controller: _webViewController),
      ),
    );
  }

  void showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}