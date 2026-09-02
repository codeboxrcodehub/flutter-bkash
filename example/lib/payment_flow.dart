/// Every flow exposed by `FlutterBkash` that this demo can drive.
///
/// Lives in its own file (rather than main.dart) so the history screen can
/// build a [PrefillRequest] targeting a flow without importing main.dart.
enum PaymentFlow {
  payWithoutAgreement('Pay'),
  payWithAgreement('Pay with agreement'),
  createAgreement('Create agreement'),
  refund('Refund'),
  refundStatus('Refund status');

  const PaymentFlow(this.label);

  final String label;
}
