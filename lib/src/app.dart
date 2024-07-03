import 'package:flutter/material.dart';
import 'package:nos_net/src/pages/home.dart';
import 'package:nos_net/src/pages/login.dart';
import 'package:nos_net/src/providers/auth.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nos Net',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isLoggedIn) {
              return const HomePage();
            }
            return const LoginPage();
          },
        ));
  }
}
