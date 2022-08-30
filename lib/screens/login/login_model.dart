class AuthRequest {
  String? username;
  String? password;

  AuthRequest({this.username, this.password});

  AuthRequest.fromJson(Map<String, dynamic> json) {
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

class AuthResponse {
  String? email;
  String? username;
  String? accessToken;
  String? publicToken;
  String? userId;
  String? message;
  bool? error;

  AuthResponse(
      {this.email,
      this.username,
      this.accessToken,
      this.publicToken,
      this.userId,
      this.message,
      this.error});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    accessToken = json['accessToken'];
    publicToken = json['publicToken'];
    userId = json['userId'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['accessToken'] = accessToken;
    data['publicToken'] = publicToken;
    data['userId'] = userId;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
