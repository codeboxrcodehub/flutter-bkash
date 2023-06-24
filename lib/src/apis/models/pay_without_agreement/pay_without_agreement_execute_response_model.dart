// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PayWithoutAgreementExecuteResponseModel {
  final String statusCode;
  final String statusMessage;
  final String paymentID;
  final String payerReference;
  final String customerMsisdn;
  final String trxID;
  final String amount;
  final String transactionStatus;
  final String paymentExecuteTime;
  final String currency;
  final String intent;
  final String merchantInvoiceNumber;

  PayWithoutAgreementExecuteResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.paymentID,
    required this.payerReference,
    required this.customerMsisdn,
    required this.trxID,
    required this.amount,
    required this.transactionStatus,
    required this.paymentExecuteTime,
    required this.currency,
    required this.intent,
    required this.merchantInvoiceNumber,
  });

  PayWithoutAgreementExecuteResponseModel copyWith({
    String? statusCode,
    String? statusMessage,
    String? paymentID,
    String? payerReference,
    String? customerMsisdn,
    String? trxID,
    String? amount,
    String? transactionStatus,
    String? paymentExecuteTime,
    String? currency,
    String? intent,
    String? merchantInvoiceNumber,
  }) {
    return PayWithoutAgreementExecuteResponseModel(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      paymentID: paymentID ?? this.paymentID,
      payerReference: payerReference ?? this.payerReference,
      customerMsisdn: customerMsisdn ?? this.customerMsisdn,
      trxID: trxID ?? this.trxID,
      amount: amount ?? this.amount,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      paymentExecuteTime: paymentExecuteTime ?? this.paymentExecuteTime,
      currency: currency ?? this.currency,
      intent: intent ?? this.intent,
      merchantInvoiceNumber:
          merchantInvoiceNumber ?? this.merchantInvoiceNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'paymentID': paymentID,
      'payerReference': payerReference,
      'customerMsisdn': customerMsisdn,
      'trxID': trxID,
      'amount': amount,
      'transactionStatus': transactionStatus,
      'paymentExecuteTime': paymentExecuteTime,
      'currency': currency,
      'intent': intent,
      'merchantInvoiceNumber': merchantInvoiceNumber,
    };
  }

  factory PayWithoutAgreementExecuteResponseModel.fromMap(
      Map<String, dynamic> map) {
    return PayWithoutAgreementExecuteResponseModel(
      statusCode: map['statusCode'] as String? ?? "",
      statusMessage: map['statusMessage'] as String? ?? "",
      paymentID: map['paymentID'] as String? ?? "",
      payerReference: map['payerReference'] as String? ?? "",
      customerMsisdn: map['customerMsisdn'] as String? ?? "",
      trxID: map['trxID'] as String? ?? "",
      amount: map['amount'] as String? ?? "",
      transactionStatus: map['transactionStatus'] as String? ?? "",
      paymentExecuteTime: map['paymentExecuteTime'] as String? ?? "",
      currency: map['currency'] as String? ?? "",
      intent: map['intent'] as String? ?? "",
      merchantInvoiceNumber: map['merchantInvoiceNumber'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PayWithoutAgreementExecuteResponseModel.fromJson(String source) =>
      PayWithoutAgreementExecuteResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PayWithoutAgreementExecuteResponseModel(statusCode: $statusCode, statusMessage: $statusMessage, paymentID: $paymentID, payerReference: $payerReference, customerMsisdn: $customerMsisdn, trxID: $trxID, amount: $amount, transactionStatus: $transactionStatus, paymentExecuteTime: $paymentExecuteTime, currency: $currency, intent: $intent, merchantInvoiceNumber: $merchantInvoiceNumber)';
  }

  @override
  bool operator ==(covariant PayWithoutAgreementExecuteResponseModel other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.paymentID == paymentID &&
        other.payerReference == payerReference &&
        other.customerMsisdn == customerMsisdn &&
        other.trxID == trxID &&
        other.amount == amount &&
        other.transactionStatus == transactionStatus &&
        other.paymentExecuteTime == paymentExecuteTime &&
        other.currency == currency &&
        other.intent == intent &&
        other.merchantInvoiceNumber == merchantInvoiceNumber;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        statusMessage.hashCode ^
        paymentID.hashCode ^
        payerReference.hashCode ^
        customerMsisdn.hashCode ^
        trxID.hashCode ^
        amount.hashCode ^
        transactionStatus.hashCode ^
        paymentExecuteTime.hashCode ^
        currency.hashCode ^
        intent.hashCode ^
        merchantInvoiceNumber.hashCode;
  }
}
