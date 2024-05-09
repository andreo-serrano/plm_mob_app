class LoginResponseModel {
  final String access_token;
  final String toke_type;
  final String role;

  LoginResponseModel(
      {required this.access_token,
      required this.toke_type,
      required this.role});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      access_token: json["access_token"] != null ? json["access_token"] : "",
      toke_type: json["toke_type"] != null ? json["toke_type"] : "",
      role: json["role"] != null ? json["role"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'access_token': access_token.trim(),
      'toke_type': toke_type.trim(),
      'role': role.trim(),
    };
    return map;
  }
}

class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'password': password.trim(),
    };
    return map;
  }
}
