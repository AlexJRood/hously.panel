extension StringExtension on String {
  String capitalize() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  bool emailValidation() {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return emailRegExp.hasMatch(this);
  }

  bool urlValidation() {
    const urlPattern = r'^(http|https):\/\/[^\s$.?#].[^\s]*$';
    final result = RegExp(urlPattern, caseSensitive: false).hasMatch(this);

    return result;
  }

  bool timeValidation() {
    final timeRegExp = RegExp(r'^\d{2}:\d{2}$');

    return timeRegExp.hasMatch(this);
  }

  bool dateValidation() {
    final dateRegExp = RegExp(
        r'^(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)\s([1-9]|1[0-9]|2[0-9]|3[01]),\s\d{4}$');

    return dateRegExp.hasMatch(toUpperCase());
  }

  String formatTimeOfDay() => padLeft(2, '0');
}
