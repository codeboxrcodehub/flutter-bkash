import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

void main() {
  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'bKash Demo'),
    );
  }
}

enum PaymentType { payWithAgreement, payWithoutAgreement, createAgreement }

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _agreementIdController = TextEditingController();

  bool isLoading = false;

  PaymentType _paymentType = PaymentType.payWithoutAgreement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_paymentType != PaymentType.createAgreement) ...[
                        const Text(
                          'Amount :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            hintText: "1240",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2.0),
                            ),
                            // hintText: reviewTitle,
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                        ),
                        if (_paymentType == PaymentType.payWithAgreement) ...[
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'AgreementID :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _agreementIdController,
                            decoration: const InputDecoration(
                              hintText: "User Agreement Id",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: 2.0),
                              ),
                              // hintText: reviewTitle,
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ],
                        const SizedBox(height: 20.0),
                      ],
                      const Divider(),
                      ListTile(
                        title: const Text('Pay (without agreement)'),
                        leading: Radio(
                          value: PaymentType.payWithoutAgreement,
                          groupValue: _paymentType,
                          onChanged: (value) {
                            setState(() => _paymentType = value!);
                          },
                        ),
                        dense: true,
                      ),
                      ListTile(
                        title: const Text('Pay with Agreement'),
                        leading: Radio(
                          value: PaymentType.payWithAgreement,
                          groupValue: _paymentType,
                          onChanged: (value) {
                            setState(() => _paymentType = value!);
                          },
                        ),
                        dense: true,
                      ),
                      ListTile(
                        title: const Text('Create agreement'),
                        leading: Radio(
                          value: PaymentType.createAgreement,
                          groupValue: _paymentType,
                          onChanged: (value) {
                            setState(() => _paymentType = value!);
                          },
                        ),
                        dense: true,
                      ),
                      const Divider(),
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              backgroundColor: Colors.pink),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final flutterBkash = FlutterBkash();

                            if (_paymentType == PaymentType.createAgreement) {
                              try {
                                // remove focus from TextField to hide keyboard
                                FocusManager.instance.primaryFocus?.unfocus();
                                final result = await flutterBkash
                                    .createAgreement(context: context);
                                dev.log(result.toString());
                                _showSnackbar(
                                    "(Success) AgreementId: ${result.agreementId}");
                              } on BkashFailure catch (e, st) {
                                dev.log(e.message, error: e, stackTrace: st);
                                _showSnackbar(e.message);
                              } catch (e, st) {
                                dev.log("Something went wrong",
                                    error: e, stackTrace: st);
                                _showSnackbar("Something went wrong");
                              }
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            if (_paymentType ==
                                PaymentType.payWithoutAgreement) {
                              final amount = _amountController.text.trim();

                              if (amount.isEmpty) {
                                // if the amount is empty then show the snack-bar
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Amount is empty. Without amount you can't pay. Try again")));
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }
                              // remove focus from TextField to hide keyboard
                              FocusManager.instance.primaryFocus?.unfocus();
                              // Goto BkashPayment page & pass the params

                              try {
                                final result = await flutterBkash.pay(
                                  context: context,
                                  amount: double.parse(
                                      amount), // need it double type
                                  merchantInvoiceNumber: "tranId",
                                );

                                dev.log(result.toString());
                                _showSnackbar(
                                    "(Success) tranId: ${result.trxId}");
                              } on BkashFailure catch (e, st) {
                                dev.log(e.message, error: e, stackTrace: st);
                                _showSnackbar(e.message);
                              } catch (e, st) {
                                dev.log("Something went wrong",
                                    error: e, stackTrace: st);
                                _showSnackbar("Something went wrong");
                              }
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            if (_paymentType == PaymentType.payWithAgreement) {
                              final amount = _amountController.text.trim();
                              final agreementId =
                                  _agreementIdController.text.trim();

                              if (amount.isEmpty) {
                                // if the amount is empty then show the snack-bar
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Amount is empty. Without amount you can't pay. Try again")));
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }

                              if (agreementId.isEmpty) {
                                // if the agreementId is empty then show the snack-bar
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "AgreementId is empty. Without AgreementId you can't pay. Try again")));
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }

                              // remove focus from TextField to hide keyboard
                              FocusManager.instance.primaryFocus?.unfocus();

                              // Goto BkashPayment page & pass the params
                              try {
                                final result =
                                    await flutterBkash.payWithAgreement(
                                  context: context,
                                  amount: double.parse(amount),
                                  agreementId: agreementId,
                                  marchentInvoiceNumber:
                                      "merchantInvoiceNumber",
                                );

                                dev.log(result.toString());
                                _showSnackbar(
                                    "(Success) tranId: ${result.trxId}");
                              } on BkashFailure catch (e, st) {
                                dev.log(e.message, error: e, stackTrace: st);
                                _showSnackbar(e.message);
                              } catch (e, st) {
                                dev.log("Something went wrong",
                                    error: e, stackTrace: st);
                                _showSnackbar("Something went wrong");
                              }
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
