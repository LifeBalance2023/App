class EmailValidator {
  final RegExp _emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }

    if (!_emailRegex.hasMatch(value)) {
      return 'Please provide an email in valid form';
    }

    return null;
  }
}
