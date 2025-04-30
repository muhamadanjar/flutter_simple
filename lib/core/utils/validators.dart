class Validators {
  // Email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Masukkan alamat email yang valid';
    }

    return null;
  }

  // Password validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }

  // Required field validator
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field ini wajib diisi';
    }

    return null;
  }

  // Name validator
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }

    if (value.length < 2) {
      return 'Nama terlalu pendek';
    }

    return null;
  }
}

class ValidationRegex {
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  static final RegExp nonDigitsExp = RegExp(r'[^\d]');
  static final RegExp uppercaseLetter = RegExp(r'[A-Z]');
  static final RegExp lowercaseLetter = RegExp(r'[a-z]');
  static final RegExp number = RegExp(r'[0-9]');
  static final RegExp anyLetter = RegExp(r'[A-Za-z]');
  static final RegExp phoneRegExp = RegExp(r'^(0|\+|(\+[0-9]{2,4}|\(\+?[0-9]{2,4}\)) ?)([0-9]*|\d{2,4}-\d{2,4}(-\d{2,4})?)$');
  static final RegExp url = RegExp(
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$");
}