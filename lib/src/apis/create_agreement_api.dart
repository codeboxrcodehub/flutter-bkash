import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../bkash_credentials.dart';
import '../utils/api_helper.dart';
import '../utils/failure.dart';
import 'models/create_agreement/create_agreement_response_model.dart';
import 'models/create_agreement/execute_agreement_response.dart';

class CreateAgreementApi with ApiHelper {
  final BkashCredentials _bkashCredentials;

  late String _baseUrl;

  CreateAgreementApi(this._bkashCredentials) {
    _baseUrl =
        "https://tokenized.${_bkashCredentials.isSandbox ? "sandbox" : "pay"}.bka.sh/v1.2.0-beta";
  }

  Future<Either<BkashFailure, CreateAgreementResponseModel>> createAgreement({
    required String idToken,
    required String payerReference,
  }) async {
    final headers = {
      "accept": 'application/json',
      "Authorization": idToken,
      "X-APP-Key": _bkashCredentials.appKey,
      'content-type': 'application/json'
    };
    final body = {
      "mode": '0000',
      "payerReference": payerReference,
      "callbackURL": 'https://example.com/',
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
      (r) => right(CreateAgreementResponseModel.fromMap(r)),
    );
  }

  Future<Either<BkashFailure, ExecuteAgreementResponse>>
      executeCreateAgreement({
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
      (r) => right(ExecuteAgreementResponse.fromMap(r)),
    );
  }
}
