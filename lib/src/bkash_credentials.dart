class BkashCredentials {
  /// Username associated with the merchant account which was shared by bKash during on-boarding.
  final String username;

  /// Password associated with the merchant account.
  final String password;

  /// Application Key value shared by bKash during on-boarding.
  final String appKey;

  /// Application Secret value shared by bKash during on-boarding.
  final String appSecret;

  /// Make this false for production credentials
  final bool isSandbox;

  const BkashCredentials({
    required this.username,
    required this.password,
    required this.appKey,
    required this.appSecret,
    this.isSandbox = true,
  });
}
