class SignupValidations {
  nameValidations(String name) => name.isEmpty ? "*Name Required" : "";

  _isValidEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  emailValidations(String email) {
    print(_isValidEmail(email));
    if (email.isEmpty) {
      return "*Email required";
    } else if (!_isValidEmail(email)) {
      return "*Email invalid";
    } else {
      return "";
    }
  }

  usernameValidations(String username) {
    final bool hasSpecialChars =
        RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]{1,20}$').hasMatch(username);
    if (username.isEmpty) {
      return "*Username required";
    } else if (username.length < 5) {
      return "*Username should contain at least six characters";
    } else if (hasSpecialChars != true) {
      return "*Username should not contain any special characters";
    } else {
      return "";
    }
  }

  passwordValidation(String password) {
    bool hasAll = !RegExp(r'^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})')
        .hasMatch(password);
    if (password.isEmpty)
      return "*Password required";
    else if (hasAll)
      return "*Password must contains \n min 8 characters. \n aplpha numeric.  \n one special char.";
    else
      return "";
  }
}
