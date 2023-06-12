class BkashCredentials {
  final String username;
  final String password;
  final String appKey;
  final String appSecret;
  final bool isSandbox;

  BkashCredentials({
    required this.username,
    required this.password,
    required this.appKey,
    required this.appSecret,
    this.isSandbox = true,
  });
}
