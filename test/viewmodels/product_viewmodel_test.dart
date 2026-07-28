import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository.dart';
import 'package:vendas_app/src/models/category_model.dart';
import 'package:vendas_app/src/models/product_model.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';

class MockProductRepository extends Mock implements ProductRepository {}
class MockCategoryRepository extends Mock implements CategoryRepository {}

class FakeProductModel extends Fake implements ProductModel {}

void main() {
  late ProductViewModel viewModel;
  late MockProductRepository mockRepository;
  late MockCategoryRepository mockCategoryRepository;
  late StreamController<List<ProductModel>> productStreamController;

  setUpAll(() {
    registerFallbackValue(FakeProductModel());
  });

  setUp(() {
    mockRepository = MockProductRepository();
    mockCategoryRepository = MockCategoryRepository();
    productStreamController = StreamController<List<ProductModel>>.broadcast();

    when(() => mockRepository.watchAll()).thenAnswer((_) => productStreamController.stream);
    when(() => mockCategoryRepository.watchAll()).thenAnswer((_) => const Stream.empty());

    viewModel = ProductViewModel(mockRepository, mockCategoryRepository);
  });

  tearDown(() {
    productStreamController.close();
  });

  group('ProductViewModel Tests', () {
    final tProduct1 = ProductModel(name: 'Apple', price: 10.0, imageUrl: '', category: 'Frutas');
    final tProduct2 = ProductModel(name: 'Banana', price: 5.0, imageUrl: '', category: 'Frutas');
    final tProduct3 = ProductModel(name: 'TV', price: 1000.0, imageUrl: '', category: 'Eletrônicos');
    final tProductsList = [tProduct1, tProduct2, tProduct3];

    test('should update products list reactively when watchAll emits', () async {
      expect(viewModel.products, isEmpty);
      productStreamController.add(tProductsList);
      await pumpEventQueue();
      expect(viewModel.products, tProductsList);
      expect(viewModel.isLoading, false);
    });

    test('loadProducts should fetch from repository and include category repository categories', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      when(() => mockCategoryRepository.getAll()).thenAnswer((_) async => [
        CategoryModel(name: 'Livros'),
        CategoryModel(name: 'Frutas'),
      ]);

      await viewModel.loadProducts();

      expect(viewModel.products, tProductsList);
      expect(viewModel.categories.contains('Frutas'), true);
      expect(viewModel.categories.contains('Livros'), true);
      expect(viewModel.categories.contains('Todos'), true);
    });

    test('filterByCategory should update the filtered list', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      when(() => mockCategoryRepository.getAll()).thenAnswer((_) async => []);

      await viewModel.loadProducts();
      viewModel.filterByCategory('Frutas');

      expect(viewModel.products.length, 2);
      expect(viewModel.products.every((p) => p.category == 'Frutas'), true);
    });

    test('sortByName should sort products alphabetically', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      when(() => mockCategoryRepository.getAll()).thenAnswer((_) async => []);
      await viewModel.loadProducts();

      viewModel.sortByName(ascending: true);
      expect(viewModel.products.first.name, 'Apple');
      expect(viewModel.products.last.name, 'TV');

      viewModel.sortByName(ascending: false);
      expect(viewModel.products.first.name, 'TV');
    });

    test('sortByPrice should sort products by price', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      when(() => mockCategoryRepository.getAll()).thenAnswer((_) async => []);
      await viewModel.loadProducts();

      viewModel.sortByPrice(ascending: true);
      expect(viewModel.products.first.price, 5.0); // Banana
      expect(viewModel.products.last.price, 1000.0); // TV
    });

    test('toggleFavorite should update repository', () async {
      when(() => mockRepository.update(any())).thenAnswer((_) async {});
      productStreamController.add(tProductsList);
      await pumpEventQueue();

      await viewModel.toggleFavorite(tProduct1.id);

      verify(() => mockRepository.update(any())).called(1);
    });

    test('updateProduct should update repository', () async {
      when(() => mockRepository.update(any())).thenAnswer((_) async {});

      await viewModel.updateProduct(tProduct1);

      verify(() => mockRepository.update(tProduct1)).called(1);
    });

    test('deleteProduct should delete from repository', () async {
      when(() => mockRepository.delete(any())).thenAnswer((_) async {});

      await viewModel.deleteProduct(tProduct1.id);

      verify(() => mockRepository.delete(tProduct1.id)).called(1);
    });
  });
}

