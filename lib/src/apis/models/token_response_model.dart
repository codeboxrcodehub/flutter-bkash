import 'dart:convert';

class TokenResponseModel {
  final String statusCode;
  final String statusMessage;
  final String idToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;

  const TokenResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.idToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
  });

  TokenResponseModel copyWith({
    String? statusCode,
    String? statusMessage,
    String? idToken,
    String? tokenType,
    int? expiresIn,
    String? refreshToken,
  }) {
    return TokenResponseModel(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      idToken: idToken ?? this.idToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'id_token': idToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
    };
  }

  factory TokenResponseModel.fromMap(Map<String, dynamic> map) {
    return TokenResponseModel(
      statusCode: map['statusCode'] as String? ?? "",
      statusMessage: map['statusMessage'] as String? ?? "",
      idToken: map['id_token'] as String? ?? "",
      tokenType: map['token_type'] as String? ?? "",
      expiresIn: map['expires_in'] as int? ?? 0,
      refreshToken: map['refresh_token'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenResponseModel.fromJson(String source) =>
      TokenResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokenResponseModel(statusCode: $statusCode, statusMessage: $statusMessage, idToken: $idToken, tokenType: $tokenType, expiresIn: $expiresIn, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(covariant TokenResponseModel other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.idToken == idToken &&
        other.tokenType == tokenType &&
        other.expiresIn == expiresIn &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        statusMessage.hashCode ^
        idToken.hashCode ^
        tokenType.hashCode ^
        expiresIn.hashCode ^
        refreshToken.hashCode;
  }
}
