// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PayWithAgreementResponseModel {
  final String statusCode;
  final String statusMessage;
  final String paymentID;
  final String bkashURL;
  final String callbackURL;
  final String successCallbackURL;
  final String failureCallbackURL;
  final String cancelledCallbackURL;
  final String amount;
  final String intent;
  final String currency;
  final String agreementID;
  final String paymentCreateTime;
  final String transactionStatus;
  final String merchantInvoiceNumber;

  PayWithAgreementResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.paymentID,
    required this.bkashURL,
    required this.callbackURL,
    required this.successCallbackURL,
    required this.failureCallbackURL,
    required this.cancelledCallbackURL,
    required this.amount,
    required this.intent,
    required this.currency,
    required this.agreementID,
    required this.paymentCreateTime,
    required this.transactionStatus,
    required this.merchantInvoiceNumber,
  });

  PayWithAgreementResponseModel copyWith({
    String? statusCode,
    String? statusMessage,
    String? paymentID,
    String? bkashURL,
    String? callbackURL,
    String? successCallbackURL,
    String? failureCallbackURL,
    String? cancelledCallbackURL,
    String? amount,
    String? intent,
    String? currency,
    String? agreementID,
    String? paymentCreateTime,
    String? transactionStatus,
    String? merchantInvoiceNumber,
  }) {
    return PayWithAgreementResponseModel(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      paymentID: paymentID ?? this.paymentID,
      bkashURL: bkashURL ?? this.bkashURL,
      callbackURL: callbackURL ?? this.callbackURL,
      successCallbackURL: successCallbackURL ?? this.successCallbackURL,
      failureCallbackURL: failureCallbackURL ?? this.failureCallbackURL,
      cancelledCallbackURL: cancelledCallbackURL ?? this.cancelledCallbackURL,
      amount: amount ?? this.amount,
      intent: intent ?? this.intent,
      currency: currency ?? this.currency,
      agreementID: agreementID ?? this.agreementID,
      paymentCreateTime: paymentCreateTime ?? this.paymentCreateTime,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      merchantInvoiceNumber:
          merchantInvoiceNumber ?? this.merchantInvoiceNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'paymentID': paymentID,
      'bkashURL': bkashURL,
      'callbackURL': callbackURL,
      'successCallbackURL': successCallbackURL,
      'failureCallbackURL': failureCallbackURL,
      'cancelledCallbackURL': cancelledCallbackURL,
      'amount': amount,
      'intent': intent,
      'currency': currency,
      'agreementID': agreementID,
      'paymentCreateTime': paymentCreateTime,
      'transactionStatus': transactionStatus,
      'merchantInvoiceNumber': merchantInvoiceNumber,
    };
  }

  factory PayWithAgreementResponseModel.fromMap(Map<String, dynamic> map) {
    return PayWithAgreementResponseModel(
      statusCode: map['statusCode'] as String? ?? "",
      statusMessage: map['statusMessage'] as String? ?? "",
      paymentID: map['paymentID'] as String? ?? "",
      bkashURL: map['bkashURL'] as String? ?? "",
      callbackURL: map['callbackURL'] as String? ?? "",
      successCallbackURL: map['successCallbackURL'] as String? ?? "",
      failureCallbackURL: map['failureCallbackURL'] as String? ?? "",
      cancelledCallbackURL: map['cancelledCallbackURL'] as String? ?? "",
      amount: map['amount'] as String? ?? "",
      intent: map['intent'] as String? ?? "",
      currency: map['currency'] as String? ?? "",
      agreementID: map['agreementID'] as String? ?? "",
      paymentCreateTime: map['paymentCreateTime'] as String? ?? "",
      transactionStatus: map['transactionStatus'] as String? ?? "",
      merchantInvoiceNumber: map['merchantInvoiceNumber'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PayWithAgreementResponseModel.fromJson(String source) =>
      PayWithAgreementResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PayWithAgreementResponseModel(statusCode: $statusCode, statusMessage: $statusMessage, paymentID: $paymentID, bkashURL: $bkashURL, callbackURL: $callbackURL, successCallbackURL: $successCallbackURL, failureCallbackURL: $failureCallbackURL, cancelledCallbackURL: $cancelledCallbackURL, amount: $amount, intent: $intent, currency: $currency, agreementID: $agreementID, paymentCreateTime: $paymentCreateTime, transactionStatus: $transactionStatus, merchantInvoiceNumber: $merchantInvoiceNumber)';
  }

  @override
  bool operator ==(covariant PayWithAgreementResponseModel other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.paymentID == paymentID &&
        other.bkashURL == bkashURL &&
        other.callbackURL == callbackURL &&
        other.successCallbackURL == successCallbackURL &&
        other.failureCallbackURL == failureCallbackURL &&
        other.cancelledCallbackURL == cancelledCallbackURL &&
        other.amount == amount &&
        other.intent == intent &&
        other.currency == currency &&
        other.agreementID == agreementID &&
        other.paymentCreateTime == paymentCreateTime &&
        other.transactionStatus == transactionStatus &&
        other.merchantInvoiceNumber == merchantInvoiceNumber;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        statusMessage.hashCode ^
        paymentID.hashCode ^
        bkashURL.hashCode ^
        callbackURL.hashCode ^
        successCallbackURL.hashCode ^
        failureCallbackURL.hashCode ^
        cancelledCallbackURL.hashCode ^
        amount.hashCode ^
        intent.hashCode ^
        currency.hashCode ^
        agreementID.hashCode ^
        paymentCreateTime.hashCode ^
        transactionStatus.hashCode ^
        merchantInvoiceNumber.hashCode;
  }
}
