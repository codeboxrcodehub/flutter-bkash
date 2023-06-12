import 'dart:developer';

class Failure implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  Failure({
    String? message,
    this.error,
    this.stackTrace,
  }) : message = message ?? "Something went wrong" {
    log(
      this.message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
