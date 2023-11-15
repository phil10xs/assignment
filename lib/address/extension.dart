extension GetInitials on String {
  String? fieldvalidation({String? field}) {
    if (toString().length < 1) {
      return '$field field is required';
    } else {
      return null;
    }
  }
}
