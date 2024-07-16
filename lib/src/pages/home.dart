import 'package:flutter/material.dart';
import 'package:nos_net/src/widgets/router_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: RouterList(),
      ),
    );
  }
}
