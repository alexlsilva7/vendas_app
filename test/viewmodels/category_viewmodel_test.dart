import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository.dart';
import 'package:vendas_app/src/models/category_model.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

class FakeCategoryModel extends Fake implements CategoryModel {}

void main() {
  late CategoryViewModel viewModel;
  late MockCategoryRepository mockRepository;
  late StreamController<List<CategoryModel>> categoryStreamController;

  setUpAll(() {
    registerFallbackValue(FakeCategoryModel());
  });

  setUp(() {
    mockRepository = MockCategoryRepository();
    categoryStreamController = StreamController<List<CategoryModel>>.broadcast();
    when(() => mockRepository.watchAll()).thenAnswer((_) => categoryStreamController.stream);
    viewModel = CategoryViewModel(mockRepository);
  });

  tearDown(() {
    categoryStreamController.close();
  });

  group('CategoryViewModel Tests', () {
    final tCategory = CategoryModel(name: 'Eletrônicos');
    final tCategoriesList = [tCategory];

    test('should update categories list reactively when watchAll emits', () async {
      expect(viewModel.categories, isEmpty);
      categoryStreamController.add(tCategoriesList);
      await pumpEventQueue();
      expect(viewModel.categories, tCategoriesList);
      expect(viewModel.isLoading, false);
    });

    test('loadCategories should set isLoading and update categories list', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tCategoriesList);

      final future = viewModel.loadCategories();
      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
      expect(viewModel.categories, tCategoriesList);
      verify(() => mockRepository.getAll()).called(1);
    });

    test('addCategory should call repository', () async {
      when(() => mockRepository.add(any())).thenAnswer((_) async {});

      await viewModel.addCategory('Eletrônicos');

      verify(() => mockRepository.add(any())).called(1);
    });

    test('updateCategory should update repository', () async {
      when(() => mockRepository.update(any())).thenAnswer((_) async {});

      await viewModel.updateCategory(tCategory.id, 'Nova Categoria');

      verify(() => mockRepository.update(any())).called(1);
    });

    test('deleteCategory should delete from repository', () async {
      when(() => mockRepository.delete(any())).thenAnswer((_) async {});

      await viewModel.deleteCategory(tCategory.id);

      verify(() => mockRepository.delete(tCategory.id)).called(1);
    });
  });
}
