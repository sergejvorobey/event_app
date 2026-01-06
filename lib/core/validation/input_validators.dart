String validateLogin(String login) {
  if (login.isEmpty) return 'Начните вводить логин';
  if (login.length < 3) return 'Логин должен содержать минимум 3 символа';
  if (login.length > 20) return 'Логин должен содержать максимум 20 символов';

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(login)) return 'Недопустимый формат логина';

  final digitsOnlyRegex = RegExp(r'^\d+$');
  if (digitsOnlyRegex.hasMatch(login))
    return 'Логин не должен состоять только из цифр';

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
  if (digitsOnlyRegex.hasMatch(password))
    return 'Пароль не должен состоять только из цифр';

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
  if (digitsOnlyRegex.hasMatch(confirmPassword))
    return 'Пароль не должен состоять только из цифр';

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
  if (email.isEmpty) return ''; // 'Начните вводить почту';

  final regex = RegExp("^[A-Za-z](.*)([@]{1})(.{1,})(\\.)(.{1,})");
  if (!regex.hasMatch(email)) return 'Недопустимый формат почты';

  return "";
}

String validatePhoneNumber(String phone) {
  if (phone.isEmpty) return 'Начните вводить номер телефона';

  // Строго: только +7 и ровно 11 цифр
  final regex = RegExp(r'^\+7\d{10}$');

  if (!regex.hasMatch(phone)) {
    return 'Номер телефона должен быть в формате +7XXXXXXXXXX';
  }

  return "";
}

String validateTelegramUsername(String username) {
  if (username.isEmpty) return 'Начните вводить Telegram-ник';

  if (username.length < 5) {
    return 'Ник должен содержать минимум 5 символов';
  }

  if (username.length > 32) {
    return 'Ник должен содержать максимум 32 символа';
  }

  final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');
  if (!regex.hasMatch(username)) {
    return 'Ник должен начинаться с буквы и содержать только латиницу, цифры и "_"';
  }

  if (username.startsWith('_') || username.endsWith('_')) {
    return 'Ник не должен начинаться или заканчиваться "_"';
  }

  if (username.contains('__')) {
    return 'Ник не должен содержать подряд два "_"';
  }

  return "";
}

String validateMaxUsername(String username) {
  if (username.isEmpty) return 'Начните вводить MAX-ник';

  if (username.length < 5) {
    return 'Ник должен содержать минимум 5 символов';
  }

  if (username.length > 32) {
    return 'Ник должен содержать максимум 32 символа';
  }

  final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');
  if (!regex.hasMatch(username)) {
    return 'Ник должен начинаться с буквы и содержать только латиницу, цифры и "_"';
  }

  if (username.startsWith('_') || username.endsWith('_')) {
    return 'Ник не должен начинаться или заканчиваться "_"';
  }

  if (username.contains('__')) {
    return 'Ник не должен содержать подряд два "_"';
  }

  return "";
}

String validateProfession(String profession) {
  if (profession.isEmpty) return 'Начните вводить профессию';

  if (profession.length < 3) {
    return 'Профессия должена содержать минимум 3 символа';
  }

  if (profession.length > 20) {
    return 'Профессия должена содержать максимум 20 символов';
  }

  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(profession)) return 'Недопустимый формат профессии';

  final digitsOnlyRegex = RegExp(r'^\d+$');
  if (digitsOnlyRegex.hasMatch(profession)) {
    return 'Профессия не должена состоять только из цифр';
  }

  return "";
}

String validateBirthday(String birthday) {
  if (birthday.isEmpty) return 'Выберите из списка'; // 'Начните вводить почту';

  // final regex = RegExp("^[A-Za-z](.*)([@]{1})(.{1,})(\\.)(.{1,})");
  // if (!regex.hasMatch(email)) return 'Недопустимый формат почты';

  return "";
}

String validateCity(String birthday) {
  if (birthday.isEmpty) return 'Выберите из списка'; // 'Начните вводить почту';

  // final regex = RegExp("^[A-Za-z](.*)([@]{1})(.{1,})(\\.)(.{1,})");
  // if (!regex.hasMatch(email)) return 'Недопустимый формат почты';

  return "";
}
