import '../payment_flow.dart';

/// Emitted when the user picks a follow-up action on a [HistoryEntry]
/// (e.g. "Pay with this agreement"), so the caller can switch flow and
/// prefill its form fields from a saved record instead of retyping IDs.
class PrefillRequest {
  final PaymentFlow flow;
  final String? agreementId;
  final String? paymentId;
  final String? trxId;

  const PrefillRequest({
    required this.flow,
    this.agreementId,
    this.paymentId,
    this.trxId,
  });
}
