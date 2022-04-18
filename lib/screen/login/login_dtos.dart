class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class LoginResponse {
  String? username;
  String? accessToken;
  String? publicToken;
  String? userId;
  String? message;
  bool? error;

  LoginResponse(
      {this.username,
      this.accessToken,
      this.publicToken,
      this.userId,
      this.message,
      this.error});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accessToken = json['accessToken'];
    publicToken = json['publicToken'];
    userId = json['userId'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['accessToken'] = accessToken;
    data['publicToken'] = publicToken;
    data['userId'] = userId;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
