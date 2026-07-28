import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:vendas_app/src/application/helpers/currency_helper.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_memory_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.productViewModel,
    required this.cartViewModel,
  });

  final ProductModel product;
  final ProductViewModel productViewModel;
  final CartViewModel cartViewModel;

  static const double _cardRadius = 24;
  static const double _notchRadius = 22;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => cartViewModel.addToCart(product),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipPath(
                  clipper: _NotchedCardClipper(
                    radius: _cardRadius,
                    notchRadius: _notchRadius,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      product.imageUrl.isNotEmpty
                          ? Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                                color: Color(0xFFEDEDED),
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          : const ColoredBox(
                              color: Color(0xFFEDEDED),
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.55),
                            ],
                            stops: const [0.55, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              CurrencyHelper.format(product.price),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Material(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(_notchRadius),
                  topRight: Radius.circular(_notchRadius),
                ),
                child: InkWell(
                  onTap: () => cartViewModel.addToCart(product),
                  hoverColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(blue: 0.7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(_notchRadius),
                    topRight: Radius.circular(_notchRadius),
                  ),
                  child: SizedBox(
                    width: _notchRadius * 2,
                    height: _notchRadius * 2,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotchedCardClipper extends CustomClipper<Path> {
  _NotchedCardClipper({required this.radius, required this.notchRadius});

  final double radius;
  final double notchRadius;

  @override
  Path getClip(Size size) {
    final cardPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final notchPath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width, 0),
          radius: notchRadius,
        ),
      );

    return Path.combine(PathOperation.difference, cardPath, notchPath);
  }

  @override
  bool shouldReclip(covariant _NotchedCardClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.notchRadius != notchRadius;
  }
}

@Preview(name: 'ProductCard', group: 'home', size: Size(200, 300))
Widget previewProductCard() {
  return ProductCard(
    product: ProductModel(
      name: 'Notebook',
      price: 2500,
      imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=600&auto=format&fit=crop',
      category: 'Informática',
    ),
    productViewModel: ProductViewModel(
      ProductRepositoryImpl(ProductMemoryLocalDatasource()),
    ),
    cartViewModel: CartViewModel(
      OrderRepositoryImpl(OrderMemoryLocalDatasource()),
    ),
  );
}
