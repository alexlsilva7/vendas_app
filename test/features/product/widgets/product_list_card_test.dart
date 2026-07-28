import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/application/helpers/currency_helper.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/features/product/product_list_page.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/product/widgets/product_list_card.dart';
import 'package:vendas_app/src/models/product_model.dart';

void main() {
  testWidgets('shows product data and exposes CRUD actions', (tester) async {
    var editPressed = false;
    var deletePressed = false;
    final product = ProductModel(
      name: 'Notebook',
      price: 2500,
      imageUrl: '',
      category: 'Informática',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductListCard(
            product: product,
            onEdit: () => editPressed = true,
            onDelete: () => deletePressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Notebook'), findsOneWidget);
    expect(find.text('Informática'), findsOneWidget);
    expect(find.text(CurrencyHelper.format(product.price)), findsOneWidget);

    await tester.tap(find.byTooltip('Editar produto'));
    await tester.tap(find.byTooltip('Excluir produto'));

    expect(editPressed, isTrue);
    expect(deletePressed, isTrue);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);
    expect(find.byIcon(Icons.add_shopping_cart), findsNothing);
  });

  testWidgets('renders CachedNetworkImage when product has image URL', (tester) async {
    final productWithImage = ProductModel(
      name: 'Mouse Gamer',
      price: 150,
      imageUrl: 'https://example.com/mouse.jpg',
      category: 'Periféricos',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductListCard(
            product: productWithImage,
            onEdit: () {},
            onDelete: () {},
          ),
        ),
      ),
    );

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('product page renders products as a list without cart UI', (
    tester,
  ) async {
    final viewModel = ProductViewModel(
      ProductRepositoryImpl(ProductMemoryLocalDatasource()),
    );
    await viewModel.loadProducts();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: viewModel,
        child: const MaterialApp(home: ProductListPage()),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsNothing);
    expect(find.byType(ProductListCard), findsWidgets);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);
  });
}
