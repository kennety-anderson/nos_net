import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nos_net/src/models/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouterProvider with ChangeNotifier {
  List<RouterModel> _routers = [];

  List<RouterModel> get routers => _routers;

  Future<void> fetchRouters() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final String routerUrl = dotenv.env['ROUTERS_URL']!;
    final url = Uri.parse('$routerUrl/device');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'X-Core-ImpersonateMode': 'true',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      _routers = data.map((item) => RouterModel.fromJson(item)).toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load routers');
    }
  }
}
