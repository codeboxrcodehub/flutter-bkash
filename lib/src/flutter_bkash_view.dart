import 'package:flutter/material.dart';
import 'package:flutter_bkash/src/bkash_credentials.dart';
import 'package:flutter_bkash/src/bkash_payment_status.dart';
import 'package:flutter_bkash/src/cubit/payment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef PaymentStatus = void Function(BkashPaymentStatus bkashPaymentStatus);

class FlutterBkash extends StatefulWidget {
  /// Credential for your bkash marchent
  final BkashCredentials bkashCredentials;

  /// amount of the payment through bKash
  final String amount;

  /// return the payment status
  final PaymentStatus paymentStatus;

  const FlutterBkash({
    Key? key,
    required this.paymentStatus,
    required this.bkashCredentials,
    required this.amount,
  }) : super(key: key);

  @override
  FlutterBkashState createState() => FlutterBkashState();
}

class FlutterBkashState extends State<FlutterBkash> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
  }

  @override
  void dispose() {
    webViewController.clearCache();
    webViewController.clearLocalStorage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Builder(builder: (context) {
        return BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if(state is PaymentProcessingState)
          },
          child: Scaffold(
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
            body: WebViewWidget(controller: webViewController),
          ),
        );
      }),
    );
  }
}
