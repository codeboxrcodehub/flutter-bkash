// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

class BkashRefundResponse {
  final String originalTrxId;
  final String refundTrxId;
  final String refundTransactionStatus;
  final String originalTrxAmount;
  final String refundAmount;
  final String currency;
  final String sku;
  final String reason;
  final String _completedTime;

  BkashRefundResponse(
    this._completedTime, {
    required this.originalTrxId,
    required this.refundTrxId,
    required this.refundTransactionStatus,
    required this.originalTrxAmount,
    required this.refundAmount,
    required this.currency,
    required this.sku,
    required this.reason,
  });

  DateTime get completedTime {
    try {
      return DateTime.parse(_completedTime.replaceAll(" GMT+0600", ""));
    } catch (e, st) {
      log("DateTime parse Error", error: e, stackTrace: st);
      return DateTime.now();
    }
  }

  @override
  String toString() {
    return 'BkashRefundResponse(originalTrxId: $originalTrxId, refundTrxId: $refundTrxId, refundTransactionStatus: $refundTransactionStatus, originalTrxAmount: $originalTrxAmount, refundAmount: $refundAmount, currency: $currency, sku: $sku, reason: $reason, _completedTime: $_completedTime)';
  }
}

class BkashRefundStatusItem {
  final String refundTrxId;
  final String refundTransactionStatus;
  final String refundAmount;
  final String _completedTime;

  BkashRefundStatusItem(
    this._completedTime, {
    required this.refundTrxId,
    required this.refundTransactionStatus,
    required this.refundAmount,
  });

  DateTime get completedTime {
    try {
      return DateTime.parse(_completedTime.replaceAll(" GMT+0600", ""));
    } catch (e, st) {
      log("DateTime parse Error", error: e, stackTrace: st);
      return DateTime.now();
    }
  }

  @override
  String toString() {
    return 'BkashRefundStatusItem(refundTrxId: $refundTrxId, refundTransactionStatus: $refundTransactionStatus, refundAmount: $refundAmount, _completedTime: $_completedTime)';
  }
}

class BkashRefundStatusResponse {
  final String originalTrxId;
  final String originalTrxAmount;
  final String originalTrxCompletedTime;
  final List<BkashRefundStatusItem> refundTransactions;

  BkashRefundStatusResponse({
    required this.originalTrxId,
    required this.originalTrxAmount,
    required this.originalTrxCompletedTime,
    required this.refundTransactions,
  });

  @override
  String toString() {
    return 'BkashRefundStatusResponse(originalTrxId: $originalTrxId, originalTrxAmount: $originalTrxAmount, originalTrxCompletedTime: $originalTrxCompletedTime, refundTransactions: $refundTransactions)';
  }
}
