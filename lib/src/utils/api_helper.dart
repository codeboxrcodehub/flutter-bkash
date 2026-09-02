import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import 'failure.dart';

mixin ApiHelper {
  Future<Either<BkashFailure, Map<String, dynamic>>> networkCallHelper({
    required bool logResponse,
    required Future<Response> Function() function,
  }) async {
    try {
      final response = await function.call();

      if (logResponse) {
        log(response.body, name: "Flutter Bkash");
      }

      switch (response.statusCode) {
        case 200:
          return right(json.decode(response.body) as Map<String, dynamic>);
        case 400:
          return left(BkashFailure(
              message: _errorMessage(response.body, "Bad Request")));
        case 401:
          return left(BkashFailure(
              message: _errorMessage(response.body, "Unauthorized Access")));
        case 403:
          return left(BkashFailure(
              message: _errorMessage(response.body, "Forbidden")));
        case 404:
          return left(BkashFailure(
              message: _errorMessage(response.body, "Not Found")));
        case 500:
          return left(BkashFailure(
              message: _errorMessage(response.body, "Internal Server Error")));
        default:
          return left(BkashFailure(message: _errorMessage(response.body, null)));
      }
    } on SocketException catch (e, st) {
      return left(BkashFailure(
        message: e.message,
        error: e,
        stackTrace: st,
      ));
    } catch (e, st) {
      return left(BkashFailure(
        error: e,
        stackTrace: st,
      ));
    }
  }

  /// bKash's error responses carry the actual reason (e.g. "Refund amount
  /// exceeds transaction amount") in the JSON body even on a 4xx/5xx status,
  /// but the field name differs by API generation — v1.2.0-beta uses
  /// `errorMessage`, the newer v2 endpoints use `errorMessageEn`. Falls back
  /// to [fallback] when the body isn't JSON or carries neither field.
  String? _errorMessage(String body, String? fallback) {
    try {
      final decoded = json.decode(body);
      if (decoded is Map) {
        final message = decoded['errorMessage'] ?? decoded['errorMessageEn'];
        if (message is String && message.isNotEmpty) {
          return message;
        }
      }
    } catch (_) {
      // response body wasn't JSON (e.g. an HTML error page) — use fallback.
    }
    return fallback;
  }
}
