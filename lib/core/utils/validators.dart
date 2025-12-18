class Validators {
  // 1. YOUR PASSWORD VALIDATOR (Integrated into the class)
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Minimum 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Add uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Add lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Add number';
    if (!RegExp(r'[!@#\\$&*~]').hasMatch(value)) return 'Add special character';
    return null;
  }

  // 2. EMAIL VALIDATOR (Required for your Login/Forgot Password pages)
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Professional Regex for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // 3. NAME VALIDATOR (Useful for the Register page)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    if (value.length < 2) return 'Name is too short';
    return null;
  }
}