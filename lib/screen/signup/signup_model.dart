class SignUpRequest {
  String? name;
  String? email;
  String? username;
  String? password;

  SignUpRequest({this.name, this.email, this.username, this.password});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class SignUpResponse {
  String? message;
  bool? hasError;
  int? status;

  SignUpResponse({this.message, this.hasError, this.status});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    hasError = json['hasError'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['hasError'] = hasError;
    data['status'] = status;
    return data;
  }
}
