import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/models/product_model.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

class FakeOrderModel extends Fake implements OrderModel {}

void main() {
  late CartViewModel viewModel;
  late MockOrderRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeOrderModel());
  });

  setUp(() {
    mockRepository = MockOrderRepository();
    viewModel = CartViewModel(mockRepository);
  });

  group('CartViewModel Tests', () {
    final tProduct = ProductModel(name: 'Item', price: 50.0, imageUrl: '');
    final tClient = ClientModel(name: 'Client', email: '', phone: '');

    test('addToCart should add an item', () {
      viewModel.addToCart(tProduct);

      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.product.id, tProduct.id);
      expect(viewModel.items.first.quantity, 1);
    });

    test('addToCart with same product should increment quantity', () {
      viewModel.addToCart(tProduct);
      viewModel.addToCart(tProduct);

      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.quantity, 2);
    });

    test('removeFromCart should remove the item completely', () {
      viewModel.addToCart(tProduct);
      viewModel.removeFromCart(tProduct.id);

      expect(viewModel.items.isEmpty, true);
    });

    test('updateQuantity should change quantity or remove if zero', () {
      viewModel.addToCart(tProduct);

      viewModel.updateQuantity(tProduct.id, 5);
      expect(viewModel.items.first.quantity, 5);
      expect(viewModel.totalAmount, 250.0);

      viewModel.updateQuantity(tProduct.id, 0);
      expect(viewModel.items.isEmpty, true);
    });

    test('checkout should throw if cart is empty', () async {
      expect(() => viewModel.checkout(), throwsException);
    });

    test('checkout should throw if no client selected', () async {
      viewModel.addToCart(tProduct);
      expect(() => viewModel.checkout(), throwsException);
    });

    test('checkout should save order without clearing cart', () async {
      when(() => mockRepository.add(any())).thenAnswer((_) async {});

      viewModel.addToCart(tProduct);
      viewModel.selectClient(tClient);

      await viewModel.checkout();

      verify(() => mockRepository.add(any())).called(1);
      expect(viewModel.items, isNotEmpty);
      expect(viewModel.selectedClient, tClient);

      viewModel.clearCart();

      expect(viewModel.items.isEmpty, true);
      expect(viewModel.selectedClient, null);
    });
  });
}
