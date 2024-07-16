import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nos_net/src/providers/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final String loginUrl = dotenv.env['AUTH_BASE_URL']!;
  final String callbackUrl = dotenv.env['AUTH_CALLBACK_URL']!;
  final String clientId = dotenv.env['AUTH_CLIENT_ID']!;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForAuthorizationCode();
    });
  }

  void _checkForAuthorizationCode() {
    final uri = Uri.base;

    if (uri.queryParameters.containsKey('code')) {
      final code = uri.queryParameters['code'];
      _loginWithAuthorizationCode(code!);
    }
  }

  void _loginWithAuthorizationCode(String code) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.loginWithCode(code);
    } catch (e) {
      print('Error during login with code: $e');
    }
  }

  void _loginWithWebAuth(BuildContext context) {
    final url =
        '$loginUrl/authorize?client_id=$clientId&scope=openid+profile+customer_info+offline_access&response_type=code&redirect_uri=$callbackUrl&state=foo&auto_login=&login&code_challenge=&code_challenge_method=&sign_up=false';

    html.window.location.href = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _loginWithWebAuth(context),
                child: const Text('Login with External Service'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
