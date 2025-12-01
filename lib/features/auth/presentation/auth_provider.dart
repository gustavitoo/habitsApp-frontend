import 'package:flutter/material.dart';
import 'package:habits_app/features/auth/data/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  Future<void> checkAuth() async {
    _token = await _authRepository.getToken();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _token = await _authRepository.login(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _token = null;
    notifyListeners();
  }

  Future<bool> register(
    String name,
    String lastName,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      _token = await _authRepository.register(name, lastName, email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
      return false;
    }
  }
}
