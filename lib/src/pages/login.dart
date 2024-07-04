import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:nos_net/src/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final String loginUrl = dotenv.env['AUTH_BASE_URL'] ?? '';
  final String callbackUrl = dotenv.env['AUTH_CALLBACK_URL'] ?? '';
  final String clientId = dotenv.env['AUTH_CLIENT_ID'] ?? '';

  Future<void> _loginWithWebAuth(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            '$loginUrl/authorize?client_id=$clientId&scope=openid&response_type=code&redirect_uri=$callbackUrl',
        callbackUrlScheme: 'nostv',
      );

      print('parsed uri ==== $result');
      // if (token != null) {
      //   await authProvider.login(token);
      // }
    } catch (e) {
      print('Error during authentication: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
