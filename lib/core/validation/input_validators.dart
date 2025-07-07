String validateLogin(String login) {
  if (login.isEmpty) return 'Начните вводить логин';
  if (login.length < 3) return 'Логин должен содержать минимум 3 символа';
  if (login.length > 20) return 'Логин должен содержать максимум 20 символов';

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(login)) return 'Недопустимый формат логина';

  final digitsOnlyRegex = RegExp(r'^\d+$');
  if (digitsOnlyRegex.hasMatch(login)) return 'Логин не должен состоять только из цифр';

  return "";
}

String validatePassword(String password, String confirmPassword) {
  if (password.isEmpty) return 'Начните вводить пароль';
  if (password.length < 6) return 'Пароль должен содержать минимум 6 символов';
  if (password.length > 20) {
    return 'Пароль должен содержать максимум 20 символов';
  }

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(password)) return 'Недопустимый формат пароля';

  final digitsOnlyRegex = RegExp(r'^\d+$');
  if (digitsOnlyRegex.hasMatch(password)) return 'Пароль не должен состоять только из цифр';

  if (confirmPassword.isNotEmpty) {
    if (password != confirmPassword) return 'Пароли не совпадают';
  }

  return "";
}

String validateConfirmPassword(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) return 'Начните вводить пароль';
  if (confirmPassword.length < 6) {
    return 'Пароль должен содержать минимум 6 символов';
  }
  if (confirmPassword.length > 20) {
    return 'Пароль должен содержать максимум 20 символов';
  }

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(confirmPassword)) return 'Недопустимый формат пароля';

  final digitsOnlyRegex = RegExp(r'^\d+$');
  if (digitsOnlyRegex.hasMatch(confirmPassword)) return 'Пароль не должен состоять только из цифр';

  if (password != confirmPassword) return 'Пароли не совпадают';
  return "";
}

String validateFirstName(String firstName) {
  if (firstName.isEmpty) return 'Начните вводить имя';
  if (firstName.length < 2) return 'Имя должно содержать минимум 2 буквы';
  if (firstName.length > 20) return 'Имя должно содержать максимум 10 букв';

  final regex = RegExp(r'^[A-ZА-Я][a-zа-яё]+$');
  if (!regex.hasMatch(firstName)) {
    return 'Имя должно начинаться с заглавной буквы и содержать только буквы';
  }

  return "";
}

String validateLastName(String lastName) {
  if (lastName.isEmpty) return 'Начните вводить фамилию';
  if (lastName.length < 2) return 'Фамилия должна содержать минимум 2 буквы';
  if (lastName.length > 10) return 'Фамилия должна содержать максимум 10 букв';

  final regex = RegExp(r'^[A-ZА-Я][a-zа-яё]+$');
  if (!regex.hasMatch(lastName)) {
    return 'Фамилия должна начинаться с заглавной буквы и содержать только буквы';
  }

  return "";
}

String validateEmail(String email) {
  if (email.isEmpty) return 'Начните вводить почту';

  final regex = RegExp("^[A-Za-z](.*)([@]{1})(.{1,})(\\.)(.{1,})");
  if (!regex.hasMatch(email)) return 'Недопустимый формат почты';

  return "";
}
