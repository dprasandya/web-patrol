import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null && _token != null;

  // Login method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.login(email, password);
      
      _token = result['token'];
      _user = result['user'];
      
      // Save to local storage
      await _saveAuthData(_token!, _user!);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    await _authService.logout();
    await _clearAuthData();
    
    _user = null;
    _token = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Auto-login from saved data
  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userData = prefs.getString('user');

    if (token != null && userData != null) {
      final isValid = await _authService.validateToken(token);
      
      if (isValid) {
        _token = token;
        _user = User.fromJson(jsonDecode(userData));
        notifyListeners();
        return true;
      } else {
        await _clearAuthData();
      }
    }
    return false;
  }

  // Save authentication data to local storage
  Future<void> _saveAuthData(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  // Clear authentication data from local storage
  Future<void> _clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
