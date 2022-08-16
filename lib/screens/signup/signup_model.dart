class SignUpRequest {
  String? name;
  String? email;
  String? username;
  String? password;
  String? referalCode;

  SignUpRequest(
      {this.name, this.email, this.username, this.password, this.referalCode});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    referalCode = json['referalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    data['referalCode'] = referalCode;
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
    hasError = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = hasError;
    data['status'] = status;
    return data;
  }
}
