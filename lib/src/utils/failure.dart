import 'dart:developer';

class BkashFailure implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  BkashFailure({
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

class CancelledFailure extends BkashFailure {
  CancelledFailure({
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) : super(
          message: "User Cancelled Payment",
          error: error,
          stackTrace: stackTrace,
        );
}
