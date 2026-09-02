/// Which [FlutterBkash] flow produced a [HistoryEntry].
///
/// Drives the icon/color shown in the history list and which follow-up
/// action (pay-with-agreement, refund, check-status) is offered for it.
enum HistoryType { payment, agreement, refund, refundStatus }

/// One saved record of a completed demo action, persisted on-device so the
/// IDs it carries (paymentId, trxId, agreementId) can be reused later —
/// e.g. refunding a payment made in a previous app session.
class HistoryEntry {
  final String id;
  final HistoryType type;
  final DateTime savedAt;
  final String title;

  /// IDs needed to feed this entry into a follow-up flow. Kept separate from
  /// [details] so prefill logic doesn't depend on matching display labels.
  final String? paymentId;
  final String? trxId;
  final String? agreementId;

  /// Every field worth showing/copying in the details view, in display order.
  final Map<String, String> details;

  const HistoryEntry({
    required this.id,
    required this.type,
    required this.savedAt,
    required this.title,
    required this.details,
    this.paymentId,
    this.trxId,
    this.agreementId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'savedAt': savedAt.toIso8601String(),
        'title': title,
        'paymentId': paymentId,
        'trxId': trxId,
        'agreementId': agreementId,
        'details': details,
      };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      id: json['id'] as String,
      type: HistoryType.values.firstWhere((t) => t.name == json['type']),
      savedAt: DateTime.parse(json['savedAt'] as String),
      title: json['title'] as String,
      paymentId: json['paymentId'] as String?,
      trxId: json['trxId'] as String?,
      agreementId: json['agreementId'] as String?,
      details: Map<String, String>.from(json['details'] as Map),
    );
  }
}
