import 'package:flutter/material.dart';
import 'package:nos_net/src/models/router.dart';
import 'package:nos_net/src/pages/router_detail.dart';
import 'package:nos_net/src/providers/router.dart';
import 'package:provider/provider.dart';

class RouterList extends StatelessWidget {
  const RouterList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<RouterProvider>(context, listen: false).fetchRouters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Consumer<RouterProvider>(
            builder: (context, routerProvider, child) {
              return ListView.builder(
                itemCount: routerProvider.routers.length,
                itemBuilder: (context, index) {
                  RouterModel router = routerProvider.routers[index];
                  return ListTile(
                    title: Text(
                      router.friendlyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(router.mac),
                        const Text(
                          'Router disponível!',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RouterDetailScreen(router: router),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
