import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import 'failure.dart';

mixin ApiHelper {
  Future<Either<Failure, Map<String, dynamic>>> networkCallHelper({
    required Future<Response> Function() function,
  }) async {
    try {
      final response = await function.call();

      switch (response.statusCode) {
        case 200:
          return right(json.decode(response.body) as Map<String, dynamic>);
        case 400:
          return left(Failure(message: "Bad Request"));
        case 401:
          return left(Failure(message: "Unauthorized Access"));
        case 403:
          return left(Failure(message: "Forbidden"));
        case 404:
          return left(Failure(message: "Not Found"));
        case 500:
          return left(Failure(message: "Internal Server Error"));
        default:
          return left(Failure());
      }
    } on SocketException catch (e, st) {
      return left(Failure(
        message: e.message,
        error: e,
        stackTrace: st,
      ));
    } catch (e, st) {
      return left(Failure(
        error: e,
        stackTrace: st,
      ));
    }
  }
}
