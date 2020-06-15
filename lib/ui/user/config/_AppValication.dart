class AppValidation {
  static bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool passwordValidation(String password, String confirmPass) {
    if (password.length < 8 || password.isEmpty) {
      return false;
    } else if (password != confirmPass) {
      return false;
    } else {
      return true;
    }
  }

  static bool passwordValidationLogin(String password) {
    return (password.length < 8 || password.isEmpty);
  }

  static bool namesValidation(String email) {
    return RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$")
        .hasMatch(email);
  }

  static bool idCardValidation(String idCard) {
    print("idCardValidation -> "+(idCard.length < 8 || idCard.isEmpty).toString());
    return !(idCard.length < 8 || idCard.isEmpty);
  }

  static bool cnssValidation(String idCard) {
    return !(idCard.length < 6 || idCard.isEmpty);
  }
}
