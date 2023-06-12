import 'package:flutter_bkash/src/apis/create_agreement_api.dart';
import 'package:flutter_bkash/src/apis/pay_with_agreement_api.dart';
import 'package:flutter_bkash/src/apis/pay_without_agreement_api.dart';
import 'package:flutter_bkash/src/apis/token_api.dart';
import 'package:flutter_bkash/src/bkash_credentials.dart';

class BkashApi {
  final BkashCredentials _bkashCredentials;

  late TokenApi _tokenApi;
  late CreateAgreementApi _createAgreementApi;
  late PayWithAgreementApi _payWithAgreementApi;
  late PayWithoutAgreementApi _payWithoutAgreementApi;

  BkashApi(this._bkashCredentials) {
    _tokenApi = TokenApi(_bkashCredentials);
    _createAgreementApi = CreateAgreementApi(_bkashCredentials);
    _payWithAgreementApi = PayWithAgreementApi(_bkashCredentials);
    _payWithoutAgreementApi = PayWithoutAgreementApi(_bkashCredentials);
  }
}
