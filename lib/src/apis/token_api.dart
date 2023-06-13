import 'dart:convert';

import 'package:flutter_bkash/src/utils/api_helper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../bkash_credentials.dart';
import '../utils/failure.dart';
import 'models/token_response_model.dart';

class TokenApi with ApiHelper {
  final BkashCredentials _bkashCredentials;

  late String _baseUrl;

  TokenApi(this._bkashCredentials) {
    _baseUrl =
        "https://tokenized.${_bkashCredentials.isSandbox ? "sandbox" : "pay"}.bka.sh/v1.2.0-beta";
  }

  Future<Either<BkashFailure, TokenResponseModel>> createToken() async {
    final headers = {
      "accept": 'application/json',
      "username": _bkashCredentials.username,
      "password": _bkashCredentials.password,
      'content-type': 'application/json'
    };
    final body = {
      "app_key": _bkashCredentials.appKey,
      "app_secret": _bkashCredentials.appSecret,
    };

    final data = await networkCallHelper(
      function: () => http.post(
        Uri.parse("$_baseUrl/tokenized/checkout/token/grant"),
        headers: headers,
        body: json.encode(body),
      ),
    );

    return data.fold(
      (l) => left(l),
      (r) => right(TokenResponseModel.fromMap(r)),
    );
  }

  Future<Either<BkashFailure, TokenResponseModel>> refreshToken({
    required String refreshToken,
  }) async {
    final headers = {
      "accept": 'application/json',
      "username": _bkashCredentials.username,
      "password": _bkashCredentials.password,
      'content-type': 'application/json'
    };
    final body = {
      "app_key": _bkashCredentials.appKey,
      "app_secret": _bkashCredentials.appSecret,
      "refresh_token": refreshToken,
    };

    final data = await networkCallHelper(
      function: () => http.post(
        Uri.parse("$_baseUrl/tokenized/checkout/token/refresh"),
        headers: headers,
        body: json.encode(body),
      ),
    );

    return data.fold(
      (l) => left(l),
      (r) => right(TokenResponseModel.fromMap(r)),
    );
  }
}
