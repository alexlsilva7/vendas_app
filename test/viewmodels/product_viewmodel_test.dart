import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository.dart';
import 'package:vendas_app/src/models/product_model.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class FakeProductModel extends Fake implements ProductModel {}

void main() {
  late ProductViewModel viewModel;
  late MockProductRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeProductModel());
  });

  setUp(() {
    mockRepository = MockProductRepository();
    viewModel = ProductViewModel(mockRepository);
  });

  group('ProductViewModel Tests', () {
    final tProduct1 = ProductModel(name: 'Apple', price: 10.0, imageUrl: '', category: 'Frutas');
    final tProduct2 = ProductModel(name: 'Banana', price: 5.0, imageUrl: '', category: 'Frutas');
    final tProduct3 = ProductModel(name: 'TV', price: 1000.0, imageUrl: '', category: 'Eletrônicos');
    final tProductsList = [tProduct1, tProduct2, tProduct3];

    test('loadProducts should fetch from repository', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);

      await viewModel.loadProducts();

      expect(viewModel.products, tProductsList);
      expect(viewModel.categories.contains('Frutas'), true);
      expect(viewModel.categories.contains('Todos'), true);
    });

    test('filterByCategory should update the filtered list', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);

      await viewModel.loadProducts();
      viewModel.filterByCategory('Frutas');

      expect(viewModel.products.length, 2);
      expect(viewModel.products.every((p) => p.category == 'Frutas'), true);
    });

    test('sortByName should sort products alphabetically', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      await viewModel.loadProducts();

      viewModel.sortByName(ascending: true);
      expect(viewModel.products.first.name, 'Apple');
      expect(viewModel.products.last.name, 'TV');

      viewModel.sortByName(ascending: false);
      expect(viewModel.products.first.name, 'TV');
    });

    test('sortByPrice should sort products by price', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      await viewModel.loadProducts();

      viewModel.sortByPrice(ascending: true);
      expect(viewModel.products.first.price, 5.0); // Banana
      expect(viewModel.products.last.price, 1000.0); // TV
    });

    test('toggleFavorite should update repository and reload', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);
      when(() => mockRepository.update(any())).thenAnswer((_) async {});

      await viewModel.loadProducts();
      await viewModel.toggleFavorite(tProduct1.id);

      verify(() => mockRepository.update(any())).called(1);
      verify(() => mockRepository.getAll()).called(2); // 1 on load, 1 on toggle
    });

    test('updateProduct should update repository and reload products', () async {
      when(() => mockRepository.update(any())).thenAnswer((_) async {});
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);

      await viewModel.updateProduct(tProduct1);

      verify(() => mockRepository.update(tProduct1)).called(1);
      verify(() => mockRepository.getAll()).called(1);
    });

    test('deleteProduct should delete from repository and reload products', () async {
      when(() => mockRepository.delete(any())).thenAnswer((_) async {});
      when(() => mockRepository.getAll()).thenAnswer((_) async => tProductsList);

      await viewModel.deleteProduct(tProduct1.id);

      verify(() => mockRepository.delete(tProduct1.id)).called(1);
      verify(() => mockRepository.getAll()).called(1);
    });
  });
}
