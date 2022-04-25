class SignupValidations {
  nameValidations(String name) => name.isEmpty ? "*Name Required" : null;

  _isValidEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  _isValidUsername(String username) =>
      RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]{1,20}$').hasMatch(username);

  emailValidations(String email) {
    print(_isValidEmail(email));
    if (email.isEmpty) {
      return "*Email required";
    } else if (!_isValidEmail(email)) {
      return "*Email invalid";
    } else {
      return null;
    }
  }

  usernameValidations(String username) {
    if (username.isEmpty) {
      return "*Username Required";
    } else if (_isValidUsername(username)) {
      return "*Username should be alpha numeric with _ underscore";
    } else {
      return null;
    }
  }

  passwordValidation(String password) {
    bool hasAll =
        !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})')
            .hasMatch(password);
    if (hasAll) return "Invalid Password!";
    return null;
  }
}
