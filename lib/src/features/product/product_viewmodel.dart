import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository.dart';
import 'package:vendas_app/src/models/category_model.dart';
import 'package:vendas_app/src/models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;
  final CategoryRepository? _categoryRepository;

  List<ProductModel> _allProducts = [];
  List<CategoryModel> _registeredCategories = [];
  List<ProductModel> _filteredProducts = [];
  StreamSubscription<List<ProductModel>>? _productSubscription;
  StreamSubscription<List<CategoryModel>>? _categorySubscription;

  bool _isLoading = true;
  String _currentCategory = 'Todos';

  ProductViewModel(this._repository, [this._categoryRepository]) {
    _initReactivity();
  }

  List<ProductModel> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String get currentCategory => _currentCategory;

  List<String> get categories {
    final categoryNamesFromRepo = _registeredCategories.map((c) => c.name).toList();
    final categoryNamesFromProducts = _allProducts.map((p) => p.category).toList();

    final Set<String> uniqueCats = {...categoryNamesFromRepo, ...categoryNamesFromProducts};
    final cats = uniqueCats.where((c) => c.trim().isNotEmpty).toList();

    cats.insert(0, 'Todos');
    bool hasFavorites = _allProducts.any((p) => p.isFavorite);
    if (hasFavorites) cats.insert(1, 'Favoritos');
    return cats;
  }

  void _initReactivity() {
    _isLoading = true;
    notifyListeners();

    _productSubscription = _repository.watchAll().listen(
      (products) {
        _allProducts = products;
        _applyFilters();
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _isLoading = false;
        notifyListeners();
      },
    );

    _categorySubscription = _categoryRepository?.watchAll().listen((categories) {
      _registeredCategories = categories;
      notifyListeners();
    });
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _allProducts = await _repository.getAll();
    if (_categoryRepository != null) {
      _registeredCategories = await _categoryRepository.getAll();
    }
    _applyFilters();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    await _repository.add(product);
  }

  Future<void> updateProduct(ProductModel product) async {
    await _repository.update(product);
  }

  Future<void> deleteProduct(String productId) async {
    await _repository.delete(productId);
  }

  Future<void> toggleFavorite(String productId) async {
    final index = _allProducts.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final product = _allProducts[index];
      final updatedProduct = product.copyWith(isFavorite: !product.isFavorite);
      await _repository.update(updatedProduct);
    }
  }

  void filterByCategory(String category) {
    _currentCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void sortByName({bool ascending = true}) {
    _filteredProducts.sort((a, b) {
      return ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
    });
    notifyListeners();
  }

  void sortByPrice({bool ascending = true}) {
    _filteredProducts.sort((a, b) {
      return ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
    });
    notifyListeners();
  }

  void _applyFilters() {
    if (_currentCategory == 'Todos') {
      _filteredProducts = List.from(_allProducts);
    } else if (_currentCategory == 'Favoritos') {
      _filteredProducts = _allProducts.where((p) => p.isFavorite).toList();
    } else {
      _filteredProducts = _allProducts.where((p) => p.category == _currentCategory).toList();
    }
    sortByName(ascending: true);
  }

  @override
  void dispose() {
    _productSubscription?.cancel();
    _categorySubscription?.cancel();
    super.dispose();
  }
}
