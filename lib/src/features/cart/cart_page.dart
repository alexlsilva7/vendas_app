import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_checkout_summary.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_item_card.dart';
import 'package:vendas_app/src/features/cart/widgets/client_selector.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    final orderViewModel = context.read<OrderViewModel>();
    final theme = Theme.of(context);

    Future<void> checkout() async {
      final navigator = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);

      try {
        final order = await cartViewModel.checkout();
        await orderViewModel.loadOrders();

        if (!navigator.mounted) return;

        messenger.showSnackBar(
          const SnackBar(content: Text('Pedido realizado com sucesso!')),
        );
        navigator.pushReplacementNamed(
          '/orders/detail',
          arguments: order,
        );
        cartViewModel.clearCart(notify: false);
      } catch (error) {
        if (!messenger.mounted) return;

        messenger.showSnackBar(
          SnackBar(
            content: Text(
              error.toString().replaceAll('Exception: ', ''),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: cartViewModel.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: theme.colorScheme.outline.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Seu carrinho está vazio.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Seleção de Cliente
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ClientSelector(),
                ),
                // Lista de Itens do Carrinho
                Expanded(
                  child: ListView.builder(
                    itemCount: cartViewModel.items.length,
                    itemBuilder: (context, index) {
                      final item = cartViewModel.items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                        child: CartItemCard(item: item),
                      );
                    },
                  ),
                ),
                // Resumo Financeiro e Checkout
                CartCheckoutSummary(onCheckout: checkout),
              ],
            ),
    );
  }
}
