import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository.dart';
import 'package:vendas_app/src/models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];

  bool _isLoading = false;
  String _currentCategory = 'Todos';

  ProductViewModel(this._repository);

  List<ProductModel> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String get currentCategory => _currentCategory;

  List<String> get categories {
    final cats = _allProducts.map((p) => p.category).toSet().toList();
    cats.insert(0, 'Todos');
    bool hasFavorites = _allProducts.any((p) => p.isFavorite);
    if (hasFavorites) cats.insert(1, 'Favoritos');
    return cats;
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _allProducts = await _repository.getAll();
    _applyFilters();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    await _repository.add(product);
    await loadProducts();
  }

  Future<void> updateProduct(ProductModel product) async {
    await _repository.update(product);
    await loadProducts();
  }

  Future<void> deleteProduct(String productId) async {
    await _repository.delete(productId);
    await loadProducts();
  }

  Future<void> toggleFavorite(String productId) async {
    final index = _allProducts.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final product = _allProducts[index];
      final updatedProduct = product.copyWith(isFavorite: !product.isFavorite);
      await _repository.update(updatedProduct);
      await loadProducts();
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
  }
}
