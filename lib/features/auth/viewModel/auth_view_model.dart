import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _repository;

  AuthViewModel(this._repository);

  bool _isLoading = false;
  String? _error;

  // MARK: - Network

  Future<void> sendAuth(String login, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.sendAuth(
      login = login,
      password = password,
    );

    _isLoading = false;

    switch (result) {
      case Success(value: final authResponse):
        // _response = currencyResponse;
        print(authResponse);
      case Failure(exception: final exception):
        _error = exception.toString();
    }
  }
}
