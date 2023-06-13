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

enum Intent { sale, authorization }

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _amountController = TextEditingController();

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
            const Text(
              'Amount :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextFormField(
                focusNode: focusNode,
                controller: _amountController,
                decoration: const InputDecoration(
                  hintText: "1240",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                  // hintText: reviewTitle,
                ),
                keyboardType: TextInputType.number,
                maxLines: 1,
                minLines: 1,
              ),
            ),
            const SizedBox(height: 40.0),
            const Divider(),
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
                  String amount = _amountController.text.trim();

                  if (amount.isEmpty) {
                    // if the amount is empty then show the snack-bar
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Amount is empty. Without amount you can't pay. Try again")));
                    return;
                  }
                  // remove focus from TextField to hide keyboard
                  focusNode!.unfocus();
                  // Goto BkashPayment page & pass the params
                  final flutterBkash = FlutterBkash(
                    bkashCredentials: BkashCredentials(
                      username: "sandboxTokenizedUser02",
                      password: "sandboxTokenizedUser02@12345",
                      appKey: "4f6o0cjiki2rfm34kfdadl1eqq",
                      appSecret:
                          "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
                      isSandbox: true,
                    ),
                  );

                  try {
                    final res = await flutterBkash.pay(
                      context: context,
                      amount: 10,
                      marchentInvoiceNumber: "tranId",
                    );

                    dev.log(res.toString());
                  } catch (e) {
                    dev.log("something went wrong");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
