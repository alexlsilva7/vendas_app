import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository_impl.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';
import 'package:vendas_app/src/models/product_model.dart';

void main() {
  testWidgets('opens for the first cart item without overflowing', (
    tester,
  ) async {
    final cartViewModel = CartViewModel(
      OrderRepositoryImpl(OrderMemoryLocalDatasource()),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: cartViewModel,
        child: MaterialApp(
          routes: {
            '/cart': (_) => const Scaffold(),
          },
          home: const Scaffold(
            bottomNavigationBar: CartBottomBanner(),
          ),
        ),
      ),
    );

    cartViewModel.addToCart(
      ProductModel(
        name: 'Produto',
        price: 10,
        imageUrl: '',
        category: 'Categoria',
      ),
    );

    await tester.pump();
    expect(tester.takeException(), isNull);

    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.takeException(), isNull);

    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
  });
}
