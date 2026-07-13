import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/settings/settings_viewmodel.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = context.watch<SettingsViewModel>();
    final isDarkMode = settingsViewModel.isDarkMode;
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode ? theme.colorScheme.primaryContainer : theme.colorScheme.primary,
            ),
            child: const Text(
              'Vendas App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Clientes'),
            onTap: () {
              Navigator.pushNamed(context, '/clients');
            },
          ),
          ListTile(
            title: const Text('Produtos'),
            onTap: () {
              Navigator.pushNamed(context, '/products');
            },
          ),
          ListTile(
            title: const Text('Categorias'),
            onTap: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          ListTile(
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.pushNamed(context, '/orders');
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Modo Escuro'),
            secondary: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: isDarkMode,
            onChanged: (value) {
              context.read<SettingsViewModel>().toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
