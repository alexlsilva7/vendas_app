import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/application/ui/ui_config.dart';

import 'dependencies.dart';
import 'features/client/client_list_page.dart';
import 'features/client/client_form_page.dart';
import 'features/home/home_page.dart';
import 'features/cart/cart_page.dart';
import 'features/order/order_detail_page.dart';
import 'features/order/order_list_page.dart';
import 'features/product/product_form_page.dart';
import 'features/product/product_list_page.dart';
import 'features/category/category_list_page.dart';
import 'features/settings/settings_viewmodel.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppDependencies.providers,
      child: Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, child) {
          return MaterialApp(
            title: 'Vendas App',
            themeMode: settingsViewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: UiConfig.lightTheme,
            darkTheme: UiConfig.darkTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/clients': (context) => const ClientListPage(),
              '/clients/form': (context) => const ClientFormPage(),
              '/products': (context) => const ProductListPage(),
              '/products/form': (context) => const ProductFormPage(),
              '/categories': (context) => const CategoryListPage(),
              '/orders': (context) => const OrderListPage(),
              '/orders/detail': (context) => const OrderDetailPage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/cart') {
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) => const CartPage(),
                  transitionDuration: const Duration(milliseconds: 300),
                  reverseTransitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
                    return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(curvedAnimation),
                      child: child,
                    );
                  },
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
