String? validateLogin(String login) {
  if (login.isEmpty) return 'Начните вводить логин';
  if (login.length < 3) return 'Логин должен содержать минимум 3 символа';
  if (login.length > 20) return 'Логин должен содержать максимум 20 символов';

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(login)) return 'Недопустимый формат логина';

  return "";
}

String? validatePassword(String password) {
  if (password.isEmpty) return 'Начните вводить логин';
  if (password.length < 6) return 'Пароль должен содержать минимум 6 символов';
  if (password.length > 20) return 'Пароль должен содержать максимум 20 символов';

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(password)) return 'Недопустимый формат пароля';

  return "";
}
