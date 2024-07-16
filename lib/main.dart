import 'package:flutter/material.dart';
import 'package:nos_net/src/app.dart';
import 'package:nos_net/src/providers/auth.dart';
import 'package:nos_net/src/providers/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(token: token)),
        ChangeNotifierProvider(
            create: (_) => RouterProvider()), // Provide RouterProvider
      ],
      child: const MyApp(),
    ),
  );
}
