import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';
import 'package:vendas_app/src/features/category/widgets/category_list_card.dart';
import 'package:vendas_app/src/models/category_model.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoryViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCategoryDialog(context),
            tooltip: 'Adicionar categoria',
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.categories.isEmpty
              ? const Center(child: Text('Nenhuma categoria cadastrada.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: viewModel.categories.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final category = viewModel.categories[index];
                    return CategoryListCard(
                      category: category,
                      onEdit: () => _showCategoryDialog(context, category: category),
                      onDelete: () => _confirmDelete(context, viewModel, category),
                    );
                  },
                ),
    );
  }

  void _showCategoryDialog(BuildContext context, {CategoryModel? category}) {
    final controller = TextEditingController(text: category?.name ?? '');
    final isEditing = category != null;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEditing ? 'Editar Categoria' : 'Nova Categoria'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nome da Categoria',
            hintText: 'Ex: Eletrônicos, Roupas...',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                final viewModel = context.read<CategoryViewModel>();
                if (isEditing) {
                  viewModel.updateCategory(category.id, name);
                } else {
                  viewModel.addCategory(name);
                }
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    CategoryViewModel viewModel,
    CategoryModel category,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir categoria'),
        content: Text('Deseja excluir "${category.name}"?'),
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

    await viewModel.deleteCategory(category.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Categoria excluída com sucesso!')),
    );
  }
}
