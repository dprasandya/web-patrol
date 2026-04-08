import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  // Mock API endpoint - replace with your actual backend URL
  static const String _baseUrl = 'https://api.example.com';

  // Simulated login - replace with actual API call
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Replace this with actual HTTP request to your backend
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'token': data['token'],
          'user': User.fromJson(data['user']),
        };
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      // For demo purposes, simulate successful login with mock data
      // Remove this in production and use real API
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isNotEmpty && password.isNotEmpty) {
        return {
          'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
          'user': User(
            id: '1',
            email: email,
            name: email.split('@').first,
          ),
        };
      }
      throw Exception('Invalid credentials');
    }
  }

  // Simulated logout
  Future<void> logout() async {
    try {
      await http.post(
        Uri.parse('$_baseUrl/logout'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      // Handle logout error silently for demo
      print('Logout error: $e');
    }
  }

  // Validate token
  Future<bool> validateToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/validate'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      // For demo, assume token is valid if it exists
      return token.isNotEmpty;
    }
  }
}
