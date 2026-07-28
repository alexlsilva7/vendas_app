import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository.dart';
import 'package:vendas_app/src/models/cart_item_model.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;

  final List<CartItem> _items = [];
  ClientModel? _selectedClient;

  CartViewModel(this._orderRepository);

  List<CartItem> get items => _items;
  ClientModel? get selectedClient => _selectedClient;

  int get totalItemsCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.total);
  }

  void selectClient(ClientModel client) {
    _selectedClient = client;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex != -1) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  void clearCart({bool notify = true}) {
    _items.clear();
    _selectedClient = null;
    if (notify) {
      notifyListeners();
    }
  }

  Future<OrderModel> checkout() async {
    if (_items.isEmpty) {
      throw Exception('Carrinho vazio.');
    }
    if (_selectedClient == null) {
      throw Exception('Selecione um cliente para finalizar o pedido.');
    }

    final orderItems = _items.map((cartItem) {
      return OrderItem(product: cartItem.product, quantity: cartItem.quantity);
    }).toList();

    final newOrder = OrderModel(client: _selectedClient!, items: orderItems);

    await _orderRepository.add(newOrder);

    return newOrder;
  }
}
