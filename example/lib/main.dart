import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

import 'history/history_detail_sheet.dart';
import 'history/history_entry.dart';
import 'history/history_page.dart';
import 'history/history_store.dart';
import 'history/prefill_request.dart';
import 'info_page.dart';
import 'payment_flow.dart';

void main() {
  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// bKash's brand magenta, used as the seed for the whole demo's color scheme.
const _bkashPink = Color(0xFFE2136E);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _bkashPink),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'bKash Demo'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _amountController = TextEditingController();
  final _agreementIdController = TextEditingController();
  final _paymentIdController = TextEditingController();
  final _trxIdController = TextEditingController();
  final _refundAmountController = TextEditingController();
  final _skuController = TextEditingController();
  final _reasonController = TextEditingController();

  final _flutterBkash = FlutterBkash(logResponse: true);
  final _historyStore = HistoryStore();

  PaymentFlow _flow = PaymentFlow.payWithoutAgreement;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _agreementIdController.dispose();
    _paymentIdController.dispose();
    _trxIdController.dispose();
    _refundAmountController.dispose();
    _skuController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sandbox Info',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const InfoPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: _openHistory,
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFlowSelector(),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _buildFormForFlow(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _onSubmit,
                      child: Text(_flow == PaymentFlow.refund ||
                              _flow == PaymentFlow.refundStatus
                          ? 'Submit'
                          : 'Checkout'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  /// Opens the history list; if the user picks a follow-up action there
  /// (e.g. "Refund this"), switches flow and prefills the form for it.
  Future<void> _openHistory() async {
    final prefill = await Navigator.of(context).push<PrefillRequest>(
      MaterialPageRoute(builder: (_) => const HistoryPage()),
    );
    if (prefill != null) _applyPrefill(prefill);
  }

  void _applyPrefill(PrefillRequest r) {
    setState(() {
      _flow = r.flow;
      if (r.agreementId != null) _agreementIdController.text = r.agreementId!;
      if (r.paymentId != null) _paymentIdController.text = r.paymentId!;
      if (r.trxId != null) _trxIdController.text = r.trxId!;
    });
  }

  /// Row of chips picking which [FlutterBkash] method this demo will call.
  Widget _buildFlowSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: PaymentFlow.values.map((flow) {
        return ChoiceChip(
          label: Text(flow.label),
          selected: _flow == flow,
          onSelected: (_) => setState(() => _flow = flow),
        );
      }).toList(),
    );
  }

  Widget _buildFormForFlow() {
    switch (_flow) {
      case PaymentFlow.payWithoutAgreement:
        return _labeledField('Amount', _amountController,
            hint: '1240', keyboardType: TextInputType.number);
      case PaymentFlow.payWithAgreement:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _labeledField('Amount', _amountController,
                hint: '1240', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _labeledField('Agreement ID', _agreementIdController,
                hint: 'User agreement id'),
          ],
        );
      case PaymentFlow.createAgreement:
        return const Text(
          "Creates a bKash agreement so you can pay with only a PIN afterwards. "
          "No extra fields needed — just tap Checkout.",
        );
      case PaymentFlow.refund:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _labeledField('Payment ID', _paymentIdController,
                hint: 'From a completed payment'),
            const SizedBox(height: 16),
            _labeledField('Transaction ID (trxId)', _trxIdController,
                hint: 'From the same completed payment'),
            const SizedBox(height: 16),
            _labeledField('Refund amount', _refundAmountController,
                hint: '1240', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _labeledField('SKU', _skuController, hint: 'e.g. order-1234'),
            const SizedBox(height: 16),
            _labeledField('Reason', _reasonController,
                hint: 'e.g. customer requested refund'),
          ],
        );
      case PaymentFlow.refundStatus:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _labeledField('Payment ID', _paymentIdController,
                hint: 'From a completed payment'),
            const SizedBox(height: 16),
            _labeledField('Transaction ID (trxId)', _trxIdController,
                hint: 'From the same completed payment'),
          ],
        );
    }
  }

  Widget _labeledField(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
          keyboardType: keyboardType ?? TextInputType.text,
        ),
      ],
    );
  }

  Future<void> _onSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isLoading = true);

    switch (_flow) {
      case PaymentFlow.payWithoutAgreement:
        await _handlePayWithoutAgreement();
        break;
      case PaymentFlow.payWithAgreement:
        await _handlePayWithAgreement();
        break;
      case PaymentFlow.createAgreement:
        await _handleCreateAgreement();
        break;
      case PaymentFlow.refund:
        await _handleRefund();
        break;
      case PaymentFlow.refundStatus:
        await _handleRefundStatus();
        break;
    }

    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _handleCreateAgreement() async {
    await _run(() async {
      final result = await _flutterBkash.createAgreement(context: context);
      dev.log(result.toString());

      await _saveAndShow(HistoryEntry(
        id: _newId(),
        type: HistoryType.agreement,
        savedAt: DateTime.now(),
        title: 'Agreement ${result.agreementId}',
        agreementId: result.agreementId,
        paymentId: result.paymentId,
        details: {
          'Agreement ID': result.agreementId,
          'Payment ID': result.paymentId,
          'Customer Msisdn': result.customerMsisdn,
          'Payer Reference': result.payerReference,
          'Executed At': result.executeTime.toString(),
        },
      ));
    });
  }

  Future<void> _handlePayWithoutAgreement() async {
    final amount = _amountController.text.trim();
    if (!_requireNonEmpty(amount, "Amount")) return;

    await _run(() async {
      final result = await _flutterBkash.pay(
        context: context,
        amount: double.parse(amount),
        merchantInvoiceNumber: "tranId",
      );
      dev.log(result.toString());

      await _saveAndShow(HistoryEntry(
        id: _newId(),
        type: HistoryType.payment,
        savedAt: DateTime.now(),
        title: 'Payment ${result.trxId}',
        paymentId: result.paymentId,
        trxId: result.trxId,
        details: {
          'Transaction ID': result.trxId,
          'Payment ID': result.paymentId,
          'Customer Msisdn': result.customerMsisdn,
          'Payer Reference': result.payerReference,
          'Merchant Invoice Number': result.merchantInvoiceNumber,
          'Executed At': result.executeTime.toString(),
        },
      ));
    });
  }

  Future<void> _handlePayWithAgreement() async {
    final amount = _amountController.text.trim();
    final agreementId = _agreementIdController.text.trim();
    if (!_requireNonEmpty(amount, "Amount")) return;
    if (!_requireNonEmpty(agreementId, "AgreementId")) return;

    await _run(() async {
      final result = await _flutterBkash.payWithAgreement(
        context: context,
        amount: double.parse(amount),
        agreementId: agreementId,
        marchentInvoiceNumber: "merchantInvoiceNumber",
      );
      dev.log(result.toString());

      await _saveAndShow(HistoryEntry(
        id: _newId(),
        type: HistoryType.payment,
        savedAt: DateTime.now(),
        title: 'Payment ${result.trxId}',
        paymentId: result.paymentId,
        trxId: result.trxId,
        details: {
          'Transaction ID': result.trxId,
          'Payment ID': result.paymentId,
          'Agreement ID': agreementId,
          'Customer Msisdn': result.customerMsisdn,
          'Payer Reference': result.payerReference,
          'Merchant Invoice Number': result.merchantInvoiceNumber,
          'Executed At': result.executeTime.toString(),
        },
      ));
    });
  }

  Future<void> _handleRefund() async {
    final paymentId = _paymentIdController.text.trim();
    final trxId = _trxIdController.text.trim();
    final refundAmount = _refundAmountController.text.trim();
    final sku = _skuController.text.trim();
    final reason = _reasonController.text.trim();
    if (!_requireNonEmpty(paymentId, "Payment ID")) return;
    if (!_requireNonEmpty(trxId, "Transaction ID")) return;
    if (!_requireNonEmpty(refundAmount, "Refund amount")) return;
    // bKash's sandbox rejects a refund with "Bad Request" when either of
    // these is missing, despite the docs listing them as optional.
    if (!_requireNonEmpty(sku, "SKU")) return;
    if (!_requireNonEmpty(reason, "Reason")) return;

    await _run(() async {
      final result = await _flutterBkash.refund(
        paymentId: paymentId,
        trxId: trxId,
        refundAmount: double.parse(refundAmount),
        sku: sku,
        reason: reason,
      );
      dev.log(result.toString());

      await _saveAndShow(HistoryEntry(
        id: _newId(),
        type: HistoryType.refund,
        savedAt: DateTime.now(),
        title: 'Refund ${result.refundTrxId}',
        paymentId: paymentId,
        trxId: result.originalTrxId,
        details: {
          'Refund Transaction ID': result.refundTrxId,
          'Original Transaction ID': result.originalTrxId,
          'Status': result.refundTransactionStatus,
          'Refund Amount': '${result.refundAmount} ${result.currency}',
          'Original Amount': result.originalTrxAmount,
          'SKU': result.sku,
          'Reason': result.reason,
          'Completed At': result.completedTime.toString(),
        },
      ));
    });
  }

  Future<void> _handleRefundStatus() async {
    final paymentId = _paymentIdController.text.trim();
    final trxId = _trxIdController.text.trim();
    if (!_requireNonEmpty(paymentId, "Payment ID")) return;
    if (!_requireNonEmpty(trxId, "Transaction ID")) return;

    await _run(() async {
      final result = await _flutterBkash.refundStatus(
        paymentId: paymentId,
        trxId: trxId,
      );
      dev.log(result.toString());

      final refundDetails = <String, String>{};
      for (var i = 0; i < result.refundTransactions.length; i++) {
        final r = result.refundTransactions[i];
        refundDetails['Refund #${i + 1}'] =
            '${r.refundTransactionStatus} • ${r.refundAmount} • ${r.completedTime}';
      }

      await _saveAndShow(HistoryEntry(
        id: _newId(),
        type: HistoryType.refundStatus,
        savedAt: DateTime.now(),
        title: 'Refund status ${result.originalTrxId}',
        paymentId: paymentId,
        trxId: result.originalTrxId,
        details: {
          'Original Transaction ID': result.originalTrxId,
          'Original Amount': result.originalTrxAmount,
          'Original Completed At': result.originalTrxCompletedTime,
          ...refundDetails,
        },
      ));
    });
  }

  /// Persists [entry] then immediately surfaces it in the details sheet —
  /// the single place a user reads/copies the IDs a follow-up call needs.
  Future<void> _saveAndShow(HistoryEntry entry) async {
    await _historyStore.add(entry);
    if (!mounted) return;
    final prefill = await showHistoryDetailsSheet(context, entry);
    if (prefill != null) _applyPrefill(prefill);
  }

  /// Runs [action], routing any [BkashFailure]/unexpected error to the
  /// snack-bar the same way every flow in this demo reports failures.
  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } on BkashFailure catch (e, st) {
      dev.log(e.message, error: e, stackTrace: st);
      _showSnackbar(e.message);
    } catch (e, st) {
      dev.log("Something went wrong", error: e, stackTrace: st);
      _showSnackbar("Something went wrong");
    }
  }

  bool _requireNonEmpty(String value, String fieldName) {
    if (value.isNotEmpty) return true;
    _showSnackbar("$fieldName is empty. Try again.");
    setState(() => _isLoading = false);
    return false;
  }

  /// Every call site here is a failure/validation message — styled as an
  /// error banner so "why it failed" reads as clearly as the message text.
  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      content: Row(
        children: [
          Icon(Icons.error_outline,
              color: Theme.of(context).colorScheme.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer),
            ),
          ),
        ],
      ),
    ));

  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();
}
