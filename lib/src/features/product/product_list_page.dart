import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';
import 'package:vendas_app/src/features/product/widgets/product_card.dart';
import 'package:vendas_app/src/models/product_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    final cartViewModel = context.read<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context, productViewModel),
            tooltip: 'Ordenar Produtos',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/products/form'),
            onLongPress: () async {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('Adicionando produtos de demonstração...'),
                  duration: Duration(seconds: 1),
                ),
              );

              final staticProducts = [
                ProductModel(
                  name: 'Tenis Esportivo',
                  price: 299.90,
                  imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
                  category: 'Calcados',
                ),
                ProductModel(
                  name: 'Fone de Ouvido Bluetooth',
                  price: 199.90,
                  imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
                  category: 'Eletronicos',
                ),
                ProductModel(
                  name: 'Relogio Inteligente',
                  price: 349.90,
                  imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
                  category: 'Eletronicos',
                ),
                ProductModel(
                  name: 'Camera DSLR',
                  price: 2499.00,
                  imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=500',
                  category: 'Eletronicos',
                ),
                ProductModel(
                  name: 'Garrafa Termica',
                  price: 89.90,
                  imageUrl: 'https://images.unsplash.com/photo-1527689368864-3a821dbccc34?w=500',
                  category: 'Acessorios',
                ),
                ProductModel(
                  name: 'Teclado Mecanico RGB',
                  price: 450.00,
                  imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500',
                  category: 'Eletronicos',
                ),
                ProductModel(
                  name: 'Caneca de Cafe de Ceramica',
                  price: 35.00,
                  imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500',
                  category: 'Casa',
                ),
                ProductModel(
                  name: 'Mochila para Notebook',
                  price: 179.90,
                  imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
                  category: 'Acessorios',
                ),
                ProductModel(
                  name: 'Oculos de Sol',
                  price: 120.00,
                  imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500',
                  category: 'Acessorios',
                ),
                ProductModel(
                  name: 'Luminaria de Mesa',
                  price: 149.90,
                  imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500',
                  category: 'Casa',
                ),
                ProductModel(
                  name: 'Mouse Gamer Sem Fio',
                  price: 229.90,
                  imageUrl: 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500',
                  category: 'Eletronicos',
                ),
                ProductModel(
                  name: 'Caderno de Anotacoes',
                  price: 24.90,
                  imageUrl: 'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=500',
                  category: 'Papelaria',
                ),
              ];

              for (final product in staticProducts) {
                await productViewModel.addProduct(product);
              }

              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('Vários produtos de demonstração adicionados!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            tooltip: 'Adicionar Produto',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros de Categoria (Chips horizontais)

          // Lista de Produtos
          Expanded(
            child: productViewModel.products.isEmpty
                ? const Center(child: Text('Nenhum produto cadastrado.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: productViewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = productViewModel.products[index];
                      return ProductCard(
                        product: product,
                        productViewModel: productViewModel,
                        cartViewModel: cartViewModel,
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }

  void _showSortDialog(BuildContext context, ProductViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Ordenar por:'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByName(ascending: true);
                Navigator.pop(context);
              },
              child: const Text('Nome (A-Z)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByName(ascending: false);
                Navigator.pop(context);
              },
              child: const Text('Nome (Z-A)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByPrice(ascending: true);
                Navigator.pop(context);
              },
              child: const Text('Preço (Menor para Maior)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByPrice(ascending: false);
                Navigator.pop(context);
              },
              child: const Text('Preço (Maior para Menor)'),
            ),
          ],
        );
      },
    );
  }
}
