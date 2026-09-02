import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../bkash_credentials.dart';
import '../utils/api_helper.dart';
import '../utils/failure.dart';
import 'models/refund/refund_status_response_model.dart';
import 'models/refund/refund_transaction_response_model.dart';

class RefundApi with ApiHelper {
  final BkashCredentials _bkashCredentials;
  final bool logResponse;

  late String _baseUrl;

  RefundApi(
    this._bkashCredentials, {
    required this.logResponse,
  }) {
    _baseUrl =
        "https://tokenized.${_bkashCredentials.isSandbox ? "sandbox" : "pay"}.bka.sh/v2";
  }

  Future<Either<BkashFailure, RefundTransactionResponseModel>>
      refundTransaction({
    required String idToken,
    required String paymentId,
    required String trxId,
    required String refundAmount,
    // bKash's docs list these as optional, but the sandbox rejects a refund
    // with "Bad Request" when either is missing — required in practice.
    required String sku,
    required String reason,
  }) async {
    final headers = {
      "accept": 'application/json',
      "Authorization": idToken,
      "X-APP-Key": _bkashCredentials.appKey,
      'content-type': 'application/json'
    };
    final body = {
      "paymentId": paymentId,
      "trxId": trxId,
      "refundAmount": refundAmount,
      "sku": sku,
      "reason": reason,
    };

    final data = await networkCallHelper(
      logResponse: logResponse,
      function: () => http.post(
        Uri.parse("$_baseUrl/tokenized-checkout/refund/payment/transaction"),
        headers: headers,
        body: json.encode(body),
      ),
    );

    return data.fold(
      (l) => left(l),
      (r) => right(RefundTransactionResponseModel.fromMap(r)),
    );
  }

  Future<Either<BkashFailure, RefundStatusResponseModel>> refundStatus({
    required String idToken,
    required String paymentId,
    required String trxId,
  }) async {
    final headers = {
      "accept": 'application/json',
      "Authorization": idToken,
      "X-APP-Key": _bkashCredentials.appKey,
      'content-type': 'application/json'
    };
    final body = {
      "paymentId": paymentId,
      "trxId": trxId,
    };

    final data = await networkCallHelper(
      logResponse: logResponse,
      function: () => http.post(
        Uri.parse("$_baseUrl/tokenized-checkout/refund/payment/status"),
        headers: headers,
        body: json.encode(body),
      ),
    );

    return data.fold(
      (l) => left(l),
      (r) => right(RefundStatusResponseModel.fromMap(r)),
    );
  }
}
