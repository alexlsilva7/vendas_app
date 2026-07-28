import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:vendas_app/src/models/category_model.dart';

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  final CategoryModel category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: const Icon(Icons.category_outlined),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Editar categoria',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                  color: colorScheme.error,
                  tooltip: 'Excluir categoria',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

@Preview(name: 'CategoryListCard', group: 'category', size: Size(420, 100))
Widget previewCategoryListCard() {
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: CategoryListCard(
          category: CategoryModel(name: 'Eletrônicos'),
          onEdit: () {},
          onDelete: () {},
        ),
      ),
    ),
  );
}
