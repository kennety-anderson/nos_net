import 'package:flutter/material.dart';
import 'package:nos_net/src/models/router.dart';

class RouterDetailScreen extends StatelessWidget {
  final RouterModel router;

  const RouterDetailScreen({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(router.friendlyName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mac: ${router.mac}'),
            Text('Model: ${router.model}'),
            Text('Brand: ${router.brand}'),
            Text('Type: ${router.type}'),
            Text('Acs: ${router.acs}'),
            Text('Physical Model: ${router.physicalModel}'),
            Text(
                'Has wifi optimized for Plume?: ${router.hasWifiOptimizedForPlume}'),
          ],
        ),
      ),
    );
  }
}
