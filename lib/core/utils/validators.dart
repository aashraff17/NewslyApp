String? validateStrongPassword(String value) {
  if (value.length < 8) return 'Minimum 8 characters';
  if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Add uppercase letter';
  if (!RegExp(r'[a-z]').hasMatch(value)) return 'Add lowercase letter';
  if (!RegExp(r'[0-9]').hasMatch(value)) return 'Add number';
  if (!RegExp(r'[!@#\\$&*~]').hasMatch(value)) return 'Add special character';
  return null;
}