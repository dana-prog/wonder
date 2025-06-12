extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toSnakeCase(String a, String b) =>
      '${a.trim().toLowerCase()}_${b.trim().toLowerCase()}';
}
