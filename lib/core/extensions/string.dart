extension Validation on String? {
  String? nullOrEmptyValidator() {
    if (this != null && this!.isNotEmpty) {
      return null;
    } else {
      return 'Cannot be empty!';
    }
  }
}
