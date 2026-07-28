import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late OrderViewModel viewModel;
  late MockOrderRepository mockRepository;
  late StreamController<List<OrderModel>> orderStreamController;

  setUp(() {
    mockRepository = MockOrderRepository();
    orderStreamController = StreamController<List<OrderModel>>.broadcast();
    when(() => mockRepository.watchAll()).thenAnswer((_) => orderStreamController.stream);
    viewModel = OrderViewModel(mockRepository);
  });

  tearDown(() {
    orderStreamController.close();
  });

  group('OrderViewModel Tests', () {
    final tClient = ClientModel(name: 'Client', email: '', phone: '');
    final tOrder1 = OrderModel(client: tClient, items: [], date: DateTime(2022));
    final tOrder2 = OrderModel(client: tClient, items: [], date: DateTime(2023));
    final tOrdersList = [tOrder1, tOrder2];

    test('should update orders list reactively when watchAll emits', () async {
      expect(viewModel.orders, isEmpty);
      orderStreamController.add(tOrdersList);
      await pumpEventQueue();
      expect(viewModel.orders.length, 2);
      expect(viewModel.orders.first.date.year, 2023);
      expect(viewModel.isLoading, false);
    });

    test('loadOrders should fetch and sort by newest first by default', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tOrdersList);

      await viewModel.loadOrders();

      expect(viewModel.orders.length, 2);
      expect(viewModel.orders.first.date.year, 2023); // Mais recente
    });

    test('sortOrdersByDate should sort properly', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tOrdersList);
      await viewModel.loadOrders();

      viewModel.sortOrdersByDate(newestFirst: false);
      expect(viewModel.orders.first.date.year, 2022); // Mais antigo primeiro
    });
  });
}

