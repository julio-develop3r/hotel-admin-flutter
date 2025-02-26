import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locks_flutter/app/app_service.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            child: Image(image: AssetImage('assets/logo.jpg')),
          ),
          ListTile(
            leading: const Icon(Icons.checklist_sharp),
            title: const Text('Operaciones'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              context.go('/operations');
            },
          ),
          ListTile(
            leading: const Icon(Icons.hotel),
            title: const Text('Hoteles'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              context.go('/buildings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_rounded),
            title: const Text('Reportes'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              context.go('/reports');
            },
          ),
          const Expanded(child: SizedBox.shrink()),
          const Divider(),
          ListTile(
            title: const Text('Cerrar sesión'),
            onTap: () => AppService.instance.logout(),
          ),
        ],
      ),
    );
  }
}
