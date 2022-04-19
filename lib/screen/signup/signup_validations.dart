class SignupValidations {
  nameValidations(String name) => name.isEmpty ? "*Name Required" : null;

  _isValidEmail(String email) =>
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(email)
          ? true
          : false;

  emailValidations(String email) {
    if (email.isEmpty) return "*Email required";
    if (_isValidEmail(email)) return "*Email invalid";
    return null;
  }

  usernameValidations(String username) {
    if (username.isEmpty) return "*Username Required";
    return null;
  }

  passwordRequired(String password) =>
      password.isEmpty ? "*Password Required" : null;
  confirmPasswordRequired(String password) =>
      password.isEmpty ? "*Confirm Password Required" : null;
  needValidePassword(String password) => (null);
  validateConfirmPassword(String password, String confirmPassword) =>
      password == confirmPassword ? "*Password does'nt match" : null;
}
