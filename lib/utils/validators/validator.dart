import 'package:intl_phone_field/phone_number.dart';

class FormValidator {
  static String? isValidEmail(String? email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(email!)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? isValidFullName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return 'Please enter your full name.';
    }

    final fullNameRegExp = RegExp(r'^[a-zA-Z ]{3,}(?: [a-zA-Z ]{3,}){1,}$');
    if (!fullNameRegExp.hasMatch(fullName)) {
      return 'Please enter a valid full name.';
    }

    if (fullName.length > 85) {
      return 'Full name must not exceed 85 characters.';
    }

    return null;
  }

  static String? isValidName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return 'Please enter a valid name.';
    }
    if (fullName.length > 85) {
      return 'Name must not exceed 85 characters.';
    }
    if (fullName.length < 3) {
      return 'Name must be atleast 3 Characters';
    }

    return null;
  }

  // is valid username

  static String? isValidUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Please enter a valid username.';
    }
    if (username.length > 85) {
      return 'Username must not exceed 85 characters.';
    }
    if (username.length < 3) {
      return 'Username must be atleast 3 Characters';
    }
    return null;
  }

  static String? isValidPhone(String? phoneNo) {
    if (phoneNo == null || phoneNo.isEmpty) {
      return 'Please enter a valid phone number.';
    }
    final regExp = RegExp(
      r'^\+?[1-9]\d{1,14}$',
    );
    if (!regExp.hasMatch(phoneNo.replaceAll(RegExp(r'\s+'), ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? isValidPhoneNumber(PhoneNumber? phoneNumber) {
    if (phoneNumber == null || phoneNumber.number.isEmpty) {
      return 'Please enter a valid phone number.';
    }
    return isValidPhone(phoneNumber.completeNumber);
  }

  static String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password.';
    }

    // Check for at least 8 characters
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // Check for at least one capital letter, one number, and one symbol
    final capitalLetterRegExp = RegExp(r'[A-Z]');
    final numberRegExp = RegExp(r'[0-9]');
    final symbolRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!capitalLetterRegExp.hasMatch(password) ||
        !numberRegExp.hasMatch(password) ||
        !symbolRegExp.hasMatch(password)) {
      return 'Password must contain at least one capital letter, one number, and one symbol.';
    }

    return null;
  }

  // ============== OTP Validation ==============

  /// Validates if the input is a valid numeric OTP of specified length
  static String? isValidOTP(String? otp, {int length = 6}) {
    if (otp == null || otp.isEmpty) {
      return 'Please enter the verification code.';
    }

    if (otp.length != length) {
      return 'Code must be $length digits.';
    }

    final numericRegExp = RegExp(r'^\d+$');
    if (!numericRegExp.hasMatch(otp)) {
      return 'Code must contain only numbers.';
    }

    return null;
  }

  /// Validates if the input is a valid alphanumeric OTP of specified length
  static String? isValidAlphanumericOTP(String? otp, {int length = 6}) {
    if (otp == null || otp.isEmpty) {
      return 'Please enter the verification code.';
    }

    if (otp.length != length) {
      return 'Code must be $length characters.';
    }

    final alphanumericRegExp = RegExp(r'^[A-Za-z0-9]+$');
    if (!alphanumericRegExp.hasMatch(otp)) {
      return 'Code must contain only letters and numbers.';
    }

    return null;
  }

  /// Validates PIN (typically 4-6 digits)
  static String? isValidPIN(String? pin, {int length = 4}) {
    if (pin == null || pin.isEmpty) {
      return 'Please enter your PIN.';
    }

    if (pin.length != length) {
      return 'PIN must be $length digits.';
    }

    final numericRegExp = RegExp(r'^\d+$');
    if (!numericRegExp.hasMatch(pin)) {
      return 'PIN must contain only numbers.';
    }

    return null;
  }
}

/// Extension for easy OTP validation on String
extension OTPValidation on String {
  bool isValidOTP([int length = 6]) {
    return this.length == length && RegExp(r'^\d+$').hasMatch(this);
  }
  bool isValidAlphanumericOTP([int length = 6]) {
    return this.length == length && RegExp(r'^[A-Za-z0-9]+$').hasMatch(this);
  }
  bool isValidPIN([int length = 4]) {
    return this.length == length && RegExp(r'^\d+$').hasMatch(this);
  }
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);
  bool get isAlphanumeric => RegExp(r'^[A-Za-z0-9]+$').hasMatch(this);
}

/// Extension for sanitizing user input
extension InputSanitizer on String {
  String get digitsOnly => replaceAll(RegExp(r'[^\d]'), '');

  String get alphanumericOnly => replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

  String get lettersOnly => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  String get normalizeWhitespace => trim().replaceAll(RegExp(r'\s+'), ' ');

  String get removeWhitespace => replaceAll(RegExp(r'\s'), '');

  String sanitizeOTP({bool numericOnly = true}) {
    if (numericOnly) {
      return digitsOnly;
    }
    return alphanumericOnly;
  }

  String get sanitizePhone => replaceAll(RegExp(r'[^\d+]'), '');
  String get sanitizeEmail => trim().toLowerCase();
  String get sanitizeUsername =>
      toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '');
}
