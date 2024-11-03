String? validateEmail(String email) {
  return _generalValidator(
      email,
      RegExp(
          r'^[\w-\.]+[\w-\.](\w)\@\w+((-\w+)|(\w))\.[a-z]{2,}(\.[a-z]{2,})*$'),
      'Correo incorrecto');
}

String? _generalValidator(String text, RegExp regExp, String errorMsj) {
  if (validateEmpty(text) != null) return validateEmpty(text);
  if (!regExp.hasMatch(text)) {
    return errorMsj;
  } else {
    return null;
  }
}

String? validateEmpty(String text) {
  if (text.isEmpty) {
    return 'Campo requerido';
  } else {
    return null;
  }
}
