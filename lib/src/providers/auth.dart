import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? get token => _token;

  AuthProvider({String? token}) {
    _token = token;
  }

  bool get isLoggedIn => _token != null;

  Future<void> _saveCredentials(
      String code, String token, String idToken, String refreshToken) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('code', code);
    await prefs.setString('token', token);
    await prefs.setString('idToken', idToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<void> loginWithCode(String code) async {
    final String loginUrl = dotenv.env['AUTH_BASE_URL']!;
    final String callbackUrl = dotenv.env['AUTH_CALLBACK_URL']!;
    final String clientId = dotenv.env['AUTH_CLIENT_ID']!;
    final String authorization = dotenv.env['AUTHORIZATION']!;

    final encodedCredentials = base64Encode(utf8.encode(authorization));
    final url = Uri.parse('$loginUrl/token');

    final response = await http.post(
      url,
      headers: {'Authorization': 'Basic $encodedCredentials'},
      body: {
        'client_id': clientId,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': callbackUrl,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final token = data['access_token'];
      final idToken = data['id_token'];
      final refreshToken = data['refresh_token'];

      await _saveCredentials(code, token, idToken, refreshToken);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('code');
    await prefs.remove('token');
    await prefs.remove('idToken');
    await prefs.remove('refreshToken');

    notifyListeners();
  }
}
