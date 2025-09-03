class Authinfo {
  final String accessToken;
  final String refreshToken;
  Authinfo({required this.accessToken, required this.refreshToken});

  factory Authinfo.fromJson(Map<String, dynamic> json) {
    return Authinfo(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}
