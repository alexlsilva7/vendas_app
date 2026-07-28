import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_staggered_animations_plus/flutter_staggered_animations_plus.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/home/widgets/drawer.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/product/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    final cartViewModel = context.read<CartViewModel>();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Vendas App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Pesquisar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: productViewModel.categories.length,
                itemBuilder: (context, index) {
                  final category = productViewModel.categories[index];
                  final isSelected = productViewModel.currentCategory == category;
                  return CategoryChip(category: category, isSelected: isSelected, productViewModel: productViewModel);
                },
              ),
            ),
            Expanded(
              child: productViewModel.products.isEmpty
                  ? const Center(child: Text('Nenhum produto cadastrado.'))
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8, // <- espaço entre colunas (dá lugar pro botão flutuar)
                        mainAxisSpacing: 8, // <- espaço entre linhas
                        childAspectRatio: 0.78,
                      ),
                      itemCount: productViewModel.products.length,
                      itemBuilder: (context, index) {
                        final product = productViewModel.products[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: FadeInAnimation(
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: ProductCard(
                                product: product,
                                productViewModel: productViewModel,
                                cartViewModel: cartViewModel,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.productViewModel,
  });

  final String category;
  final bool isSelected;
  final ProductViewModel productViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (_) {
          productViewModel.filterByCategory(category);
        },
      ),
    );
  }
}

@Preview(name: 'CategoryChip', group: 'home', size: Size(200, 50))
Widget previewCategoryChip() {
  return CategoryChip(
    category: 'Todos',
    isSelected: true,
    productViewModel: ProductViewModel(ProductRepositoryImpl(ProductMemoryLocalDatasource())),
  );
}
