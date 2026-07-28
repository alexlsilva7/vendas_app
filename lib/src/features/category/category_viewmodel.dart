import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository.dart';
import 'package:vendas_app/src/models/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;
  List<CategoryModel> _categories = [];
  bool _isLoading = true;
  StreamSubscription<List<CategoryModel>>? _subscription;

  CategoryViewModel(this._repository) {
    _initReactivity();
  }

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  void _initReactivity() {
    _isLoading = true;
    notifyListeners();

    _subscription = _repository.watchAll().listen(
      (categories) {
        _categories = categories;
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await _repository.getAll();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    if (name.trim().isEmpty) return;
    final newCategory = CategoryModel(name: name.trim());
    await _repository.add(newCategory);
  }

  Future<void> updateCategory(String id, String newName) async {
    if (newName.trim().isEmpty) return;
    final updatedCategory = CategoryModel(id: id, name: newName.trim());
    await _repository.update(updatedCategory);
  }

  Future<void> deleteCategory(String id) async {
    await _repository.delete(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

