import 'package:flutter_bkash/src/apis/create_agreement_api.dart';
import 'package:flutter_bkash/src/apis/pay_with_agreement_api.dart';
import 'package:flutter_bkash/src/apis/pay_without_agreement_api.dart';
import 'package:flutter_bkash/src/apis/token_api.dart';
import 'package:flutter_bkash/src/bkash_credentials.dart';
import 'package:fpdart/fpdart.dart';

import 'apis/models/create_agreement/create_agreement_response_model.dart';
import 'apis/models/create_agreement/execute_agreement_response.dart';
import 'apis/models/pay_with_agreement/pay_with_agreement_execute_response_model.dart';
import 'apis/models/pay_with_agreement/pay_with_agreement_response_model.dart';
import 'apis/models/pay_without_agreement/pay_without_agreement_execute_response_model.dart';
import 'apis/models/pay_without_agreement/pay_without_agreement_response.dart';
import 'apis/models/token_response_model.dart';
import 'utils/failure.dart';

/// The BkashApi class provides an interface to interact with various APIs related to bKash payment integration.
///
/// This class encapsulates the functionality to create tokens, create agreements, and execute payments with or without agreements.
/// It uses the provided [BkashCredentials] to authenticate API requests.
class BkashApi {
  /// This is for printing api response from Bkash
  final bool logResponse;

  /// The API for creating tokens to authorize payment operations.
  final TokenApi _tokenApi;

  /// The API for creating and executing payment agreements.
  final CreateAgreementApi _createAgreementApi;

  /// The API for paying with an existing agreement.
  final PayWithAgreementApi _payWithAgreementApi;

  /// The API for paying without an existing agreement.
  final PayWithoutAgreementApi _payWithoutAgreementApi;

  /// Creates a new instance of the [BkashApi] with the provided [bkashCredentials].
  ///
  /// The [bkashCredentials] contains the necessary authentication information to access the bKash APIs.
  BkashApi({
    required BkashCredentials bkashCredentials,
    required this.logResponse,
  })  : _tokenApi = TokenApi(
          bkashCredentials,
          logResponse: logResponse,
        ),
        _createAgreementApi = CreateAgreementApi(
          bkashCredentials,
          logResponse: logResponse,
        ),
        _payWithAgreementApi = PayWithAgreementApi(
          bkashCredentials,
          logResponse: logResponse,
        ),
        _payWithoutAgreementApi = PayWithoutAgreementApi(
          bkashCredentials,
          logResponse: logResponse,
        );

  // Token related

  /// Creates a new token for authorizing payment operations.
  ///
  /// Returns a [TokenResponseModel] if the token creation is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, TokenResponseModel>> createToken() async =>
      await _tokenApi.createToken();

  /// Refreshes the token using the provided [refreshToken].
  ///
  /// Returns a [TokenResponseModel] if the token is refreshed successfully,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, TokenResponseModel>> refreshToken({
    required String refreshToken,
  }) async =>
      await _tokenApi.refreshToken(refreshToken: refreshToken);

  // create agreement api

  /// Creates a new agreement for the provided [payerReference].
  ///
  /// Returns a [CreateAgreementResponseModel] if the agreement creation is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, CreateAgreementResponseModel>> createAgreement({
    required String idToken,
    required String payerReference,
  }) async =>
      _createAgreementApi.createAgreement(
        idToken: idToken,
        payerReference: payerReference,
      );

  /// Executes the agreement creation with the provided [paymentId] and [idToken].
  ///
  /// Returns an [ExecuteAgreementResponse] if the execution is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, ExecuteAgreementResponse>>
      executeCreateAgreement({
    required String paymentId,
    required String idToken,
  }) async =>
          _createAgreementApi.executeCreateAgreement(
            idToken: idToken,
            paymentId: paymentId,
          );

  // pay with agreement

  /// Pays with an existing agreement using the provided [idToken], [amount], [agreementId], and [merchantInvoiceNumber].
  ///
  /// Returns a [PayWithAgreementResponseModel] if the payment is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, PayWithAgreementResponseModel>> payWithAgreement({
    required String idToken,
    required String amount,
    required String agreementId,
    required String merchantInvoiceNumber,
  }) async =>
      await _payWithAgreementApi.payWithAgreement(
        idToken: idToken,
        amount: amount,
        agreementId: agreementId,
        marchentInvoiceNumber: merchantInvoiceNumber,
      );

  /// Executes the payment with an existing agreement using the provided [paymentId] and [idToken].
  ///
  /// Returns a [PayWithAgreementExecuteResponseModel] if the execution is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, PayWithAgreementExecuteResponseModel>>
      executePayWithAgreement({
    required String paymentId,
    required String idToken,
  }) async =>
          await _payWithAgreementApi.executePayWithAgreement(
            paymentId: paymentId,
            idToken: idToken,
          );

  // pay without agreement

  /// Pays without an existing agreement using the provided [idToken], [amount], [payerReference], and [merchantInvoiceNumber].
  ///
  /// Returns a [PayWithoutAgreementResponse] if the payment is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, PayWithoutAgreementResponse>>
      payWithoutAgreement({
    required String idToken,
    required String amount,
    required String payerReference,
    required String merchantInvoiceNumber,
  }) async =>
          await _payWithoutAgreementApi.payWithoutAgreement(
            idToken: idToken,
            amount: amount,
            payerReference: payerReference,
            marchentInvoiceNumber: merchantInvoiceNumber,
          );

  /// Executes the payment without an existing agreement using the provided [paymentId] and [idToken].
  ///
  /// Returns a [PayWithoutAgreementExecuteResponseModel] if the execution is successful,
  /// or a [BkashFailure] indicating the reason for failure.
  Future<Either<BkashFailure, PayWithoutAgreementExecuteResponseModel>>
      executePayWithoutAgreement({
    required String paymentId,
    required String idToken,
  }) async =>
          await _payWithoutAgreementApi.executePayWithoutAgreement(
            paymentId: paymentId,
            idToken: idToken,
          );
}
