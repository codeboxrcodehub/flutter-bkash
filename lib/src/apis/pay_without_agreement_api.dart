import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../bkash_credentials.dart';
import '../utils/api_helper.dart';
import '../utils/failure.dart';
import 'models/pay_without_agreement/pay_without_agreement_execute_response_model.dart';
import 'models/pay_without_agreement/pay_without_agreement_response.dart';

class PayWithoutAgreementApi with ApiHelper {
  final BkashCredentials _bkashCredentials;

  late String _baseUrl;

  PayWithoutAgreementApi(this._bkashCredentials) {
    _baseUrl =
        "https://tokenized.${_bkashCredentials.isSandbox ? "sandbox" : "pay"}.bka.sh/v1.2.0-beta";
  }

  Future<Either<BkashFailure, PayWithoutAgreementResponse>>
      payWithoutAgreement({
    required String idToken,
    required String amount,
    required String payerReference,
    required String marchentInvoiceNumber,
  }) async {
    final headers = {
      "accept": 'application/json',
      "Authorization": idToken,
      "X-APP-Key": _bkashCredentials.appKey,
      'content-type': 'application/json'
    };
    final body = {
      "mode": '0011',
      "payerReference": payerReference,
      "callbackURL": 'https://example.com/',
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
      (r) => right(PayWithoutAgreementResponse.fromMap(r)),
    );
  }

  Future<Either<BkashFailure, PayWithoutAgreementExecuteResponseModel>>
      executePayWithoutAgreement({
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
      (r) => right(PayWithoutAgreementExecuteResponseModel.fromMap(r)),
    );
  }
}
