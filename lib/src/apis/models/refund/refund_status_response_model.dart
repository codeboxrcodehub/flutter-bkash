// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RefundTransactionStatusItem {
  final String refundTrxId;
  final String refundTransactionStatus;
  final String refundAmount;
  final String completedTime;

  const RefundTransactionStatusItem({
    required this.refundTrxId,
    required this.refundTransactionStatus,
    required this.refundAmount,
    required this.completedTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refundTrxId': refundTrxId,
      'refundTransactionStatus': refundTransactionStatus,
      'refundAmount': refundAmount,
      'completedTime': completedTime,
    };
  }

  factory RefundTransactionStatusItem.fromMap(Map<String, dynamic> map) {
    return RefundTransactionStatusItem(
      refundTrxId: map['refundTrxId'] as String? ?? "",
      refundTransactionStatus: map['refundTransactionStatus'] as String? ?? "",
      refundAmount: map['refundAmount'] as String? ?? "",
      completedTime: map['completedTime'] as String? ?? "",
    );
  }

  @override
  String toString() {
    return 'RefundTransactionStatusItem(refundTrxId: $refundTrxId, refundTransactionStatus: $refundTransactionStatus, refundAmount: $refundAmount, completedTime: $completedTime)';
  }

  @override
  bool operator ==(covariant RefundTransactionStatusItem other) {
    if (identical(this, other)) return true;

    return other.refundTrxId == refundTrxId &&
        other.refundTransactionStatus == refundTransactionStatus &&
        other.refundAmount == refundAmount &&
        other.completedTime == completedTime;
  }

  @override
  int get hashCode {
    return refundTrxId.hashCode ^
        refundTransactionStatus.hashCode ^
        refundAmount.hashCode ^
        completedTime.hashCode;
  }
}

class RefundStatusResponseModel {
  final String originalTrxId;
  final String originalTrxAmount;
  final String originalTrxCompletedTime;
  final List<RefundTransactionStatusItem> refundTransactions;

  const RefundStatusResponseModel({
    required this.originalTrxId,
    required this.originalTrxAmount,
    required this.originalTrxCompletedTime,
    required this.refundTransactions,
  });

  RefundStatusResponseModel copyWith({
    String? originalTrxId,
    String? originalTrxAmount,
    String? originalTrxCompletedTime,
    List<RefundTransactionStatusItem>? refundTransactions,
  }) {
    return RefundStatusResponseModel(
      originalTrxId: originalTrxId ?? this.originalTrxId,
      originalTrxAmount: originalTrxAmount ?? this.originalTrxAmount,
      originalTrxCompletedTime:
          originalTrxCompletedTime ?? this.originalTrxCompletedTime,
      refundTransactions: refundTransactions ?? this.refundTransactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originalTrxId': originalTrxId,
      'originalTrxAmount': originalTrxAmount,
      'originalTrxCompletedTime': originalTrxCompletedTime,
      'refundTransactions': refundTransactions.map((x) => x.toMap()).toList(),
    };
  }

  factory RefundStatusResponseModel.fromMap(Map<String, dynamic> map) {
    return RefundStatusResponseModel(
      originalTrxId: map['originalTrxId'] as String? ?? "",
      originalTrxAmount: map['originalTrxAmount'] as String? ?? "",
      originalTrxCompletedTime: map['originalTrxCompletedTime'] as String? ?? "",
      refundTransactions: ((map['refundTransactions'] as List?) ?? [])
          .map((x) => RefundTransactionStatusItem.fromMap(
              Map<String, dynamic>.from(x as Map)))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RefundStatusResponseModel.fromJson(String source) =>
      RefundStatusResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RefundStatusResponseModel(originalTrxId: $originalTrxId, originalTrxAmount: $originalTrxAmount, originalTrxCompletedTime: $originalTrxCompletedTime, refundTransactions: $refundTransactions)';
  }
}
