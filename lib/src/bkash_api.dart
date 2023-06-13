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

class BkashApi {
  final TokenApi _tokenApi;
  final CreateAgreementApi _createAgreementApi;
  final PayWithAgreementApi _payWithAgreementApi;
  final PayWithoutAgreementApi _payWithoutAgreementApi;

  BkashApi({
    required BkashCredentials bkashCredentials,
  })  : _tokenApi = TokenApi(bkashCredentials),
        _createAgreementApi = CreateAgreementApi(bkashCredentials),
        _payWithAgreementApi = PayWithAgreementApi(bkashCredentials),
        _payWithoutAgreementApi = PayWithoutAgreementApi(bkashCredentials);

  // Token related
  Future<Either<BkashFailure, TokenResponseModel>> createToken() async =>
      await _tokenApi.createToken();

  Future<Either<BkashFailure, TokenResponseModel>> refreshToken(
          {required String refreshToken}) async =>
      await _tokenApi.refreshToken(refreshToken: refreshToken);

  // create agreement api
  Future<Either<BkashFailure, CreateAgreementResponseModel>> createAgreement({
    required String idToken,
  }) async =>
      _createAgreementApi.createAgreement(idToken: idToken);

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
  Future<Either<BkashFailure, PayWithAgreementResponseModel>> payWithAgreement({
    required String idToken,
    required String amount,
    required String agreementId,
    required String marchentInvoiceNumber,
  }) async =>
      await _payWithAgreementApi.payWithAgreement(
        idToken: idToken,
        amount: amount,
        agreementId: agreementId,
        marchentInvoiceNumber: marchentInvoiceNumber,
      );

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

  Future<Either<BkashFailure, PayWithoutAgreementResponse>>
      payWithoutAgreement({
    required String idToken,
    required String amount,
    required String marchentInvoiceNumber,
  }) async =>
          await _payWithoutAgreementApi.payWithoutAgreement(
            idToken: idToken,
            amount: amount,
            marchentInvoiceNumber: marchentInvoiceNumber,
          );

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
