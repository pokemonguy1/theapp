class Validation {
  static validateEmail(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  static validatePassword(String password) {
    final passwordRegExp = RegExp(r'^[a-zA-Z0-9.!@#\><*~]');
    return passwordRegExp.hasMatch(password);
  }

  static validateName(String name) {
    final nameRegExp = RegExp(r"^[a-zA-Za-z]");
    return nameRegExp.hasMatch(name);
  }

  static phoneNumberValidation(String phone) {
    final phoneRegExp = RegExp(r'^[+0-9]');
    return phoneRegExp.hasMatch(phone);
  }
}
