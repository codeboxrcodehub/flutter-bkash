// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

class BkashPaymentResponse {
  final String trxId;
  final String payerReference;
  final String paymentId;
  final String customerMsisdn;
  final String merchantInvoiceNumber;
  final String _executeTime;

  BkashPaymentResponse(
    this._executeTime, {
    required this.trxId,
    required this.payerReference,
    required this.paymentId,
    required this.customerMsisdn,
    required this.merchantInvoiceNumber,
  });

  DateTime get executeTime {
    try {
      return DateTime.parse(_executeTime.replaceAll(" GMT+0600", ""));
    } catch (e, st) {
      log("DateTime parse Error", error: e, stackTrace: st);
      return DateTime.now();
    }
  }

  @override
  String toString() {
    return 'BkashPaymentResponse(trxId: $trxId, payerReference: $payerReference, paymentId: $paymentId, customerMsisdn: $customerMsisdn, merchantInvoiceNumber: $merchantInvoiceNumber, _executeTime: $_executeTime)';
  }
}

class BkashAgreementResponse {
  final String payerReference;
  final String paymentId;
  final String customerMsisdn;
  final String agreementId;
  final String _executeTime;

  BkashAgreementResponse(
    this._executeTime, {
    required this.payerReference,
    required this.paymentId,
    required this.customerMsisdn,
    required this.agreementId,
  });

  DateTime get executeTime {
    try {
      return DateTime.parse(_executeTime.replaceAll(" GMT+0600", ""));
    } catch (e, st) {
      log("DateTime parse Error", error: e, stackTrace: st);
      return DateTime.now();
    }
  }

  @override
  String toString() {
    return 'BkashAgreementResponse(payerReference: $payerReference, paymentId: $paymentId, customerMsisdn: $customerMsisdn, agreementId: $agreementId, _executeTime: $_executeTime)';
  }
}
