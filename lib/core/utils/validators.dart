/// A collection of reusable validation methods for forms.
class AppValidators {
  /// Validator for non-empty fields.
  static String? notEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  /// Validator for email fields.
  static String? email(String? value) {
    final emptyCheck = notEmpty(value);
    if (emptyCheck != null) {
      return emptyCheck;
    }

    // A common regex for email validation.
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validator for password fields.
  /// Requires a minimum length (default is 6).
  static String? password(String? value, {int minLength = 6}) {
    final emptyCheck = notEmpty(value);
    if (emptyCheck != null) {
      return emptyCheck;
    }

    if (value!.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    return null;
  }

  /// Validator for confirming a password.
  static String? confirmPassword(String? password, String? confirmPassword) {
    final emptyCheck = notEmpty(confirmPassword);
    if (emptyCheck != null) {
      return emptyCheck;
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
