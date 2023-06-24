import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import 'failure.dart';

mixin ApiHelper {
  Future<Either<BkashFailure, Map<String, dynamic>>> networkCallHelper({
    required Future<Response> Function() function,
  }) async {
    try {
      final response = await function.call();

      switch (response.statusCode) {
        case 200:
          return right(json.decode(response.body) as Map<String, dynamic>);
        case 400:
          return left(BkashFailure(message: "Bad Request"));
        case 401:
          return left(BkashFailure(message: "Unauthorized Access"));
        case 403:
          return left(BkashFailure(message: "Forbidden"));
        case 404:
          return left(BkashFailure(message: "Not Found"));
        case 500:
          return left(BkashFailure(message: "Internal Server Error"));
        default:
          return left(BkashFailure());
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
}
