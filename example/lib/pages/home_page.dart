import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

import '../utils/style.dart';

enum Intent { sale, authorization }

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _amountController = TextEditingController();

  Intent _intent = Intent.sale;
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Amount :'),
            TextField(
              focusNode: focusNode,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                hintText: "15000",
              ),
            ),
            const SizedBox(height: 100.0),
            ListTile(
              title: const Text('Immediate'),
              leading: Radio(
                value: Intent.sale,
                groupValue: _intent,
                onChanged: (value) {
                  setState(() => _intent = value!);
                },
              ),
              dense: true,
            ),
            ListTile(
              title: const Text('Auth and Capture'),
              leading: Radio(
                value: Intent.authorization,
                groupValue: _intent,
                onChanged: (value) {
                  setState(() => _intent = value!);
                },
              ),
              dense: true,
            ),
            const SizedBox(height: 6.0),
            TextButton(
              child: const Text("Checkout"),
              onPressed: () {
                String amount = _amountController.text.trim();
                String intent = _intent == Intent.sale ? "sale" : "authorization";

                if (amount.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Amount is empty. You can't pay through bkash. Try again")));
                  return;
                }
                // remove focus from TextField to hide keyboard
                focusNode!.unfocus();
                // Goto BkashPayment page & pass the params
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BkashPayment(
                          amount: '20',
                          intent: 'sale',
                          createBKashUrl: 'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',
                          executeBKashUrl: 'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',
                          scriptUrl: 'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',
                          paymentStatus: (status, data) {
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
                              } else {
                                Style.errorToast("Payment Failed ${data[0]['errorMessage']}");
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
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                            print('status => $status');
                            print('data => $data');
                          },
                        )));
              },
            )
          ],
        ),
      ),
    );
  }
}
