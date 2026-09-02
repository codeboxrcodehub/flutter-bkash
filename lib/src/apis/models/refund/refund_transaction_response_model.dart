// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RefundTransactionResponseModel {
  final String originalTrxId;
  final String refundTrxId;
  final String refundTransactionStatus;
  final String originalTrxAmount;
  final String refundAmount;
  final String currency;
  final String completedTime;
  final String sku;
  final String reason;

  const RefundTransactionResponseModel({
    required this.originalTrxId,
    required this.refundTrxId,
    required this.refundTransactionStatus,
    required this.originalTrxAmount,
    required this.refundAmount,
    required this.currency,
    required this.completedTime,
    required this.sku,
    required this.reason,
  });

  RefundTransactionResponseModel copyWith({
    String? originalTrxId,
    String? refundTrxId,
    String? refundTransactionStatus,
    String? originalTrxAmount,
    String? refundAmount,
    String? currency,
    String? completedTime,
    String? sku,
    String? reason,
  }) {
    return RefundTransactionResponseModel(
      originalTrxId: originalTrxId ?? this.originalTrxId,
      refundTrxId: refundTrxId ?? this.refundTrxId,
      refundTransactionStatus:
          refundTransactionStatus ?? this.refundTransactionStatus,
      originalTrxAmount: originalTrxAmount ?? this.originalTrxAmount,
      refundAmount: refundAmount ?? this.refundAmount,
      currency: currency ?? this.currency,
      completedTime: completedTime ?? this.completedTime,
      sku: sku ?? this.sku,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originalTrxId': originalTrxId,
      'refundTrxId': refundTrxId,
      'refundTransactionStatus': refundTransactionStatus,
      'originalTrxAmount': originalTrxAmount,
      'refundAmount': refundAmount,
      'currency': currency,
      'completedTime': completedTime,
      'sku': sku,
      'reason': reason,
    };
  }

  factory RefundTransactionResponseModel.fromMap(Map<String, dynamic> map) {
    return RefundTransactionResponseModel(
      originalTrxId: map['originalTrxId'] as String? ?? "",
      refundTrxId: map['refundTrxId'] as String? ?? "",
      refundTransactionStatus: map['refundTransactionStatus'] as String? ?? "",
      originalTrxAmount: map['originalTrxAmount'] as String? ?? "",
      refundAmount: map['refundAmount'] as String? ?? "",
      currency: map['currency'] as String? ?? "",
      completedTime: map['completedTime'] as String? ?? "",
      sku: map['sku'] as String? ?? "",
      reason: map['reason'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory RefundTransactionResponseModel.fromJson(String source) =>
      RefundTransactionResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RefundTransactionResponseModel(originalTrxId: $originalTrxId, refundTrxId: $refundTrxId, refundTransactionStatus: $refundTransactionStatus, originalTrxAmount: $originalTrxAmount, refundAmount: $refundAmount, currency: $currency, completedTime: $completedTime, sku: $sku, reason: $reason)';
  }

  @override
  bool operator ==(covariant RefundTransactionResponseModel other) {
    if (identical(this, other)) return true;

    return other.originalTrxId == originalTrxId &&
        other.refundTrxId == refundTrxId &&
        other.refundTransactionStatus == refundTransactionStatus &&
        other.originalTrxAmount == originalTrxAmount &&
        other.refundAmount == refundAmount &&
        other.currency == currency &&
        other.completedTime == completedTime &&
        other.sku == sku &&
        other.reason == reason;
  }

  @override
  int get hashCode {
    return originalTrxId.hashCode ^
        refundTrxId.hashCode ^
        refundTransactionStatus.hashCode ^
        originalTrxAmount.hashCode ^
        refundAmount.hashCode ^
        currency.hashCode ^
        completedTime.hashCode ^
        sku.hashCode ^
        reason.hashCode;
  }
}
