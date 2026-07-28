import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_text/reel_text.dart';
import 'package:vendas_app/src/application/helpers/currency_helper.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';

class CartBottomBanner extends StatelessWidget {
  const CartBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        final hasItems = cartViewModel.items.isNotEmpty;
        final theme = Theme.of(context);

        return GestureDetector(
          onTap: () {
            if (hasItems) {
              Navigator.pushNamed(
                context,
                '/cart',
              );
            }
          },
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: hasItems
                ? SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 70,
                    child: Material(
                      color: theme.colorScheme.surface,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.shopping_cart, color: theme.colorScheme.primary, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRect(
                                      child: ReelText(
                                        '${cartViewModel.totalItemsCount} ${cartViewModel.totalItemsCount == 1 ? "item" : "itens"} no carrinho',
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    ClipRect(
                                      child: ReelText(
                                        CurrencyHelper.format(cartViewModel.totalAmount),
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/cart',
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Ver Carrinho', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
