import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../bkash_credentials.dart';
import '../utils/api_helper.dart';
import '../utils/failure.dart';
import 'models/pay_with_agreement/pay_with_agreement_execute_response_model.dart';
import 'models/pay_with_agreement/pay_with_agreement_response_model.dart';

class PayWithAgreementApi with ApiHelper {
  final BkashCredentials _bkashCredentials;

  late String _baseUrl;

  PayWithAgreementApi(this._bkashCredentials) {
    _baseUrl =
        "https://tokenized.${_bkashCredentials.isSandbox ? "sandbox" : "pay"}.bka.sh/v1.2.0-beta";
  }

  Future<Either<BkashFailure, PayWithAgreementResponseModel>> payWithAgreement({
    required String idToken,
    required String amount,
    required String agreementId,
    required String marchentInvoiceNumber,
  }) async {
    final headers = {
      "accept": 'application/json',
      "Authorization": idToken,
      "X-APP-Key": _bkashCredentials.appKey,
      'content-type': 'application/json'
    };
    final body = {
      "mode": '0001',
      "callbackURL": 'https://example.com/',
      "agreementID": agreementId,
      "amount": amount,
      "currency": 'BDT',
      "intent": 'sale',
      "merchantInvoiceNumber": marchentInvoiceNumber,
    };

    final data = await networkCallHelper(
      function: () => http.post(
        Uri.parse("$_baseUrl/tokenized/checkout/create"),
        headers: headers,
        body: json.encode(body),
      ),
    );

    return data.fold(
      (l) => left(l),
      (r) => right(PayWithAgreementResponseModel.fromMap(r)),
    );
  }

  Future<Either<BkashFailure, PayWithAgreementExecuteResponseModel>>
      executePayWithAgreement({
    required String paymentId,
    required String idToken,
  }) async {
    final headers = {
      "accept": 'application/json',
      "Authorization": idToken,
      "X-APP-Key": _bkashCredentials.appKey,
      'content-type': 'application/json'
    };
    final body = {
      "paymentID": paymentId,
    };
    final data = await networkCallHelper(
        function: () => http.post(
              Uri.parse("$_baseUrl/tokenized/checkout/execute"),
              headers: headers,
              body: json.encode(body),
            ));

    return data.fold(
      (l) => left(l),
      (r) => right(PayWithAgreementExecuteResponseModel.fromMap(r)),
    );
  }
}
