import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_memory_local_datasource.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';

void main() {
  late OrderMemoryLocalDatasource datasource;

  setUp(() {
    datasource = OrderMemoryLocalDatasource();
  });

  group('OrderMemoryLocalDatasource Tests', () {
    test('Should initialize with an empty list', () async {
      final orders = await datasource.getAll();
      expect(orders.isEmpty, true);
    });

    test('Should watchAll stream and emit updates when orders are added', () async {
      final stream = datasource.watchAll();
      final emits = <List<OrderModel>>[];
      
      final sub = stream.listen(emits.add);
      
      await Future.delayed(Duration.zero);
      expect(emits.length, 1);
      expect(emits[0].isEmpty, true);
      
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      await datasource.add(newOrder);
      
      await Future.delayed(Duration.zero);
      
      expect(emits.length, 2);
      expect(emits[1].length, 1);
      expect(emits[1].last.id, newOrder.id);
      
      await sub.cancel();
    });

    test('Should add a new order', () async {
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      
      await datasource.add(newOrder);
      
      final orders = await datasource.getAll();
      expect(orders.length, 1);
      expect(orders.last.id, newOrder.id);
    });

    test('Should update an existing order', () async {
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      await datasource.add(newOrder);
      
      final updatedOrder = newOrder.copyWith(client: tClient.copyWith(name: 'Updated'));
      await datasource.update(updatedOrder);
      
      final currentOrders = await datasource.getAll();
      expect(currentOrders.first.client.name, 'Updated');
    });

    test('Should delete an order by id', () async {
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      await datasource.add(newOrder);
      
      await datasource.delete(newOrder.id);
      
      final currentOrders = await datasource.getAll();
      expect(currentOrders.isEmpty, true);
    });
  });
}
