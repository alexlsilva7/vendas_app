import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/data/datasources/local/category/category_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository_impl.dart';
import 'package:vendas_app/src/features/category/category_list_page.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';
import 'package:vendas_app/src/features/category/widgets/category_list_card.dart';
import 'package:vendas_app/src/models/category_model.dart';

void main() {
  testWidgets('shows category data and exposes edit/delete actions', (tester) async {
    var editPressed = false;
    var deletePressed = false;
    final category = CategoryModel(name: 'Eletrônicos');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CategoryListCard(
            category: category,
            onEdit: () => editPressed = true,
            onDelete: () => deletePressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Eletrônicos'), findsOneWidget);

    await tester.tap(find.byTooltip('Editar categoria'));
    await tester.tap(find.byTooltip('Excluir categoria'));

    expect(editPressed, isTrue);
    expect(deletePressed, isTrue);
  });

  testWidgets('category page renders list of categories', (tester) async {
    final viewModel = CategoryViewModel(
      CategoryRepositoryImpl(CategoryMemoryLocalDatasource()),
    );
    await viewModel.loadCategories();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: viewModel,
        child: const MaterialApp(home: CategoryListPage()),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CategoryListCard), findsWidgets);
  });
}
