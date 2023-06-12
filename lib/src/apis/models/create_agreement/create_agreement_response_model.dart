import 'dart:convert';

class CreateAgreementResponseModel {
  final String statusCode;
  final String statusMessage;
  final String paymentID;
  final String bkashURL;
  final String callbackURL;
  final String successCallbackURL;
  final String failureCallbackURL;
  final String cancelledCallbackURL;
  final String payerReference;
  final String agreementStatus;
  final String agreementCreateTime;

  const CreateAgreementResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.paymentID,
    required this.bkashURL,
    required this.callbackURL,
    required this.successCallbackURL,
    required this.failureCallbackURL,
    required this.cancelledCallbackURL,
    required this.payerReference,
    required this.agreementStatus,
    required this.agreementCreateTime,
  });

  CreateAgreementResponseModel copyWith({
    String? statusCode,
    String? statusMessage,
    String? paymentID,
    String? bkashURL,
    String? callbackURL,
    String? successCallbackURL,
    String? failureCallbackURL,
    String? cancelledCallbackURL,
    String? payerReference,
    String? agreementStatus,
    String? agreementCreateTime,
  }) {
    return CreateAgreementResponseModel(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      paymentID: paymentID ?? this.paymentID,
      bkashURL: bkashURL ?? this.bkashURL,
      callbackURL: callbackURL ?? this.callbackURL,
      successCallbackURL: successCallbackURL ?? this.successCallbackURL,
      failureCallbackURL: failureCallbackURL ?? this.failureCallbackURL,
      cancelledCallbackURL: cancelledCallbackURL ?? this.cancelledCallbackURL,
      payerReference: payerReference ?? this.payerReference,
      agreementStatus: agreementStatus ?? this.agreementStatus,
      agreementCreateTime: agreementCreateTime ?? this.agreementCreateTime,
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
      'payerReference': payerReference,
      'agreementStatus': agreementStatus,
      'agreementCreateTime': agreementCreateTime,
    };
  }

  factory CreateAgreementResponseModel.fromMap(Map<String, dynamic> map) {
    return CreateAgreementResponseModel(
      statusCode: map['statusCode'] as String? ?? "",
      statusMessage: map['statusMessage'] as String? ?? "",
      paymentID: map['paymentID'] as String? ?? "",
      bkashURL: map['bkashURL'] as String? ?? "",
      callbackURL: map['callbackURL'] as String? ?? "",
      successCallbackURL: map['successCallbackURL'] as String? ?? "",
      failureCallbackURL: map['failureCallbackURL'] as String? ?? "",
      cancelledCallbackURL: map['cancelledCallbackURL'] as String? ?? "",
      payerReference: map['payerReference'] as String? ?? "",
      agreementStatus: map['agreementStatus'] as String? ?? "",
      agreementCreateTime: map['agreementCreateTime'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateAgreementResponseModel.fromJson(String source) =>
      CreateAgreementResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgreementResponseModel(statusCode: $statusCode, statusMessage: $statusMessage, paymentID: $paymentID, bkashURL: $bkashURL, callbackURL: $callbackURL, successCallbackURL: $successCallbackURL, failureCallbackURL: $failureCallbackURL, cancelledCallbackURL: $cancelledCallbackURL, payerReference: $payerReference, agreementStatus: $agreementStatus, agreementCreateTime: $agreementCreateTime)';
  }

  @override
  bool operator ==(covariant CreateAgreementResponseModel other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.paymentID == paymentID &&
        other.bkashURL == bkashURL &&
        other.callbackURL == callbackURL &&
        other.successCallbackURL == successCallbackURL &&
        other.failureCallbackURL == failureCallbackURL &&
        other.cancelledCallbackURL == cancelledCallbackURL &&
        other.payerReference == payerReference &&
        other.agreementStatus == agreementStatus &&
        other.agreementCreateTime == agreementCreateTime;
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
        payerReference.hashCode ^
        agreementStatus.hashCode ^
        agreementCreateTime.hashCode;
  }
}
