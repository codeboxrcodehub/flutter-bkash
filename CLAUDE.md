# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

`flutter_bkash` — a Flutter package wrapping bKash (Bangladesh mobile finance) Tokenized Checkout API v1.2.0-beta. Publishable to pub.dev. Root is the package itself; `example/` is a standalone demo Flutter app that depends on it via a relative path.

## Commands

Run from repo root unless noted.

```
flutter pub get                 # install package deps
flutter analyze                 # lint (uses analysis_options.yaml -> flutter_lints)
flutter test                    # run tests (test/flutter_bkash_test.dart)
flutter test test/flutter_bkash_test.dart   # run a single test file
dart format .                   # format (CHANGELOG notes "flutter format ." historically)
```

Example app (separate pubspec, run from `example/`):
```
cd example
flutter pub get
flutter run
```

Note: `test/flutter_bkash_test.dart` is currently an empty `void main() {}` stub — no real test coverage exists yet.

## Architecture

**Call flow:** `FlutterBkash` (public facade) → `BkashApi` (aggregates 4 sub-APIs) → per-endpoint API classes in `lib/src/apis/` (`TokenApi`, `CreateAgreementApi`, `PayWithAgreementApi`, `PayWithoutAgreementApi`) → `ApiHelper` mixin (`lib/src/utils/api_helper.dart`) does the actual `http` call and maps HTTP status codes to `Either<BkashFailure, Map>`.

**Error handling is `Either`-based (fpdart), not exceptions, until the top:** every API layer returns `Future<Either<BkashFailure, SomeResponseModel>>`. `FlutterBkash`'s public methods (`pay`, `createAgreement`, `payWithAgreement`) `.fold()` over these Eithers and only convert to a thrown `BkashFailure` at the very top, right before returning to the caller. When touching this code, preserve the `Either` chain through the internal layers — don't throw early inside `BkashApi`/`*Api` classes.

**Token lifecycle is managed internally.** `FlutterBkash._validateToken()` lazily creates a token on first use and refreshes it automatically ~5 minutes before `expiresIn` elapses (see `_tokenValidity` in `lib/src/flutter_bkash.dart`). Callers never manage tokens directly.

**Payment/agreement flow is two-phase, both phases hit bKash then a WebView UI:**
1. Create/pay-without-agreement/pay-with-agreement call returns a `bkashURL` + success/failure/cancel callback URLs.
2. `FlutterBkashView` (`lib/src/flutter_bkash_view.dart`) pushes a `WebViewController`-based screen, intercepts navigation to the callback URLs, and pops the route with a `BkashPaymentStatus` (`successed` / `failed` / `canceled`).
3. On `successed`, the corresponding `execute*` API call is made to finalize, and its response is mapped into the public `BkashPaymentResponse` / `BkashAgreementResponse` model.

**Per-endpoint structure:** each `lib/src/apis/*_api.dart` file has a matching `lib/src/apis/models/<endpoint>/` directory with request/response models (`fromMap` style parsing from the decoded JSON body). Follow this same `api.dart` + `models/<name>/` layout when adding a new bKash endpoint.

**Public API surface** is defined by what's exported from `lib/flutter_bkash.dart`: `FlutterBkash`, `BkashCredentials`, `BkashFailure`, `BkashApi`. Everything else under `lib/src/` is internal — keep new internal types unexported unless they're meant to be consumer-facing.

**Credentials:** `BkashCredentials` defaults to bKash's public sandbox credentials (hardcoded in `FlutterBkash`'s constructor) when none are supplied, so the package works out-of-the-box against sandbox. Production requires passing explicit `BkashCredentials(isSandbox: false, ...)`.

## Notes from README

- bKash does not provide test/sandbox credentials on request — only via their sales team. Don't fabricate or suggest test credentials beyond the existing hardcoded sandbox defaults.
- `example/lib/main.dart` is the canonical usage example; keep it in sync with any public API changes.
