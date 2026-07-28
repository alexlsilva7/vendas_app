import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository.dart';
import 'package:vendas_app/src/models/order_model.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _repository;

  List<OrderModel> _orders = [];
  bool _isLoading = true;
  StreamSubscription<List<OrderModel>>? _subscription;

  OrderViewModel(this._repository) {
    _initReactivity();
  }

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;

  void _initReactivity() {
    _isLoading = true;
    notifyListeners();

    _subscription = _repository.watchAll().listen(
      (orders) {
        _orders = List.from(orders);
        _orders.sort((a, b) => b.date.compareTo(a.date));
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();

    _orders = List.from(await _repository.getAll());
    _orders.sort((a, b) => b.date.compareTo(a.date));

    _isLoading = false;
    notifyListeners();
  }

  void sortOrdersByDate({bool newestFirst = true}) {
    _orders.sort((a, b) {
      return newestFirst ? b.date.compareTo(a.date) : a.date.compareTo(b.date);
    });
    notifyListeners();
  }

  void sortOrdersByTotal({bool highestFirst = true}) {
    _orders.sort((a, b) {
      return highestFirst
          ? b.totalAmount.compareTo(a.totalAmount)
          : a.totalAmount.compareTo(b.totalAmount);
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

