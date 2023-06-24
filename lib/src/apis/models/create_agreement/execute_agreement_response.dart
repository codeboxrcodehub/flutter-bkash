// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExecuteAgreementResponse {
  final String statusCode;
  final String statusMessage;
  final String paymentID;
  final String agreementID;
  final String payerReference;
  final String agreementExecuteTime;
  final String agreementStatus;
  final String customerMsisdn;

  ExecuteAgreementResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.paymentID,
    required this.agreementID,
    required this.payerReference,
    required this.agreementExecuteTime,
    required this.agreementStatus,
    required this.customerMsisdn,
  });

  ExecuteAgreementResponse copyWith({
    String? statusCode,
    String? statusMessage,
    String? paymentID,
    String? agreementID,
    String? payerReference,
    String? agreementExecuteTime,
    String? agreementStatus,
    String? customerMsisdn,
  }) {
    return ExecuteAgreementResponse(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      paymentID: paymentID ?? this.paymentID,
      agreementID: agreementID ?? this.agreementID,
      payerReference: payerReference ?? this.payerReference,
      agreementExecuteTime: agreementExecuteTime ?? this.agreementExecuteTime,
      agreementStatus: agreementStatus ?? this.agreementStatus,
      customerMsisdn: customerMsisdn ?? this.customerMsisdn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'paymentID': paymentID,
      'agreementID': agreementID,
      'payerReference': payerReference,
      'agreementExecuteTime': agreementExecuteTime,
      'agreementStatus': agreementStatus,
      'customerMsisdn': customerMsisdn,
    };
  }

  factory ExecuteAgreementResponse.fromMap(Map<String, dynamic> map) {
    return ExecuteAgreementResponse(
      statusCode: map['statusCode'] as String? ?? "",
      statusMessage: map['statusMessage'] as String? ?? "",
      paymentID: map['paymentID'] as String? ?? "",
      agreementID: map['agreementID'] as String? ?? "",
      payerReference: map['payerReference'] as String? ?? "",
      agreementExecuteTime: map['agreementExecuteTime'] as String? ?? "",
      agreementStatus: map['agreementStatus'] as String? ?? "",
      customerMsisdn: map['customerMsisdn'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ExecuteAgreementResponse.fromJson(String source) =>
      ExecuteAgreementResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExecuteAgreementResponse(statusCode: $statusCode, statusMessage: $statusMessage, paymentID: $paymentID, agreementID: $agreementID, payerReference: $payerReference, agreementExecuteTime: $agreementExecuteTime, agreementStatus: $agreementStatus, customerMsisdn: $customerMsisdn)';
  }

  @override
  bool operator ==(covariant ExecuteAgreementResponse other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.paymentID == paymentID &&
        other.agreementID == agreementID &&
        other.payerReference == payerReference &&
        other.agreementExecuteTime == agreementExecuteTime &&
        other.agreementStatus == agreementStatus &&
        other.customerMsisdn == customerMsisdn;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        statusMessage.hashCode ^
        paymentID.hashCode ^
        agreementID.hashCode ^
        payerReference.hashCode ^
        agreementExecuteTime.hashCode ^
        agreementStatus.hashCode ^
        customerMsisdn.hashCode;
  }
}
