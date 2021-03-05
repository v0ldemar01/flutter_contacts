String emailValidator(String value) {
  Pattern pattern =
    r'^[a-z0-9](\.?[a-z0-9]){3,}@g(oogle)?mail\.com$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Email format is invalid';
  } else {
    return null;
  }
}