import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/product/widgets/product_list_card.dart';
import 'package:vendas_app/src/models/product_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context, productViewModel),
            tooltip: 'Ordenar produtos',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/products/form'),
            tooltip: 'Adicionar produto',
          ),
        ],
      ),
      body: productViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productViewModel.products.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: productViewModel.products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = productViewModel.products[index];

                return ProductListCard(
                  product: product,
                  onEdit: () => Navigator.pushNamed(
                    context,
                    '/products/form',
                    arguments: product,
                  ),
                  onDelete: () => _confirmDelete(
                    context,
                    productViewModel,
                    product,
                  ),
                );
              },
            ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ProductViewModel viewModel,
    ProductModel product,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir produto'),
        content: Text('Deseja excluir "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (shouldDelete != true) {
      return;
    }

    await viewModel.deleteProduct(product.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto excluído com sucesso!')),
    );
  }

  void _showSortDialog(BuildContext context, ProductViewModel viewModel) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('Ordenar por:'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByName();
                Navigator.pop(dialogContext);
              },
              child: const Text('Nome (A-Z)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByName(ascending: false);
                Navigator.pop(dialogContext);
              },
              child: const Text('Nome (Z-A)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByPrice();
                Navigator.pop(dialogContext);
              },
              child: const Text('Preço (menor para maior)'),
            ),
            SimpleDialogOption(
              onPressed: () {
                viewModel.sortByPrice(ascending: false);
                Navigator.pop(dialogContext);
              },
              child: const Text('Preço (maior para menor)'),
            ),
          ],
        );
      },
    );
  }
}
