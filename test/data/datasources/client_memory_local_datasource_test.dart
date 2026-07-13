import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_memory_local_datasource.dart';
import 'package:vendas_app/src/models/client_model.dart';

void main() {
  late ClientMemoryLocalDatasource datasource;

  setUp(() {
    datasource = ClientMemoryLocalDatasource();
  });

  group('ClientMemoryLocalDatasource Tests', () {
    test('Should initialize with two mocked clients', () async {
      final clients = await datasource.getAll();
      expect(clients.length, 2);
      expect(clients[0].name, 'João Silva');
      expect(clients[1].name, 'Maria Souza');
    });

    test('Should watchAll stream and emit updates when clients are added', () async {
      final stream = datasource.watchAll();
      final emits = <List<ClientModel>>[];
      
      final sub = stream.listen(emits.add);
      
      await Future.delayed(Duration.zero);
      expect(emits.length, 1);
      expect(emits[0].length, 2);
      
      final newClient = ClientModel(name: 'New Client', email: '', phone: '');
      await datasource.add(newClient);
      
      await Future.delayed(Duration.zero);
      
      expect(emits.length, 2);
      expect(emits[1].length, 3);
      expect(emits[1].last.name, 'New Client');
      
      await sub.cancel();
    });

    test('Should add a new client', () async {
      final newClient = ClientModel(name: 'Teste', email: '', phone: '');
      await datasource.add(newClient);
      
      final clients = await datasource.getAll();
      expect(clients.length, 3);
      expect(clients.last.id, newClient.id);
    });

    test('Should update an existing client', () async {
      final clients = await datasource.getAll();
      final clientToUpdate = clients.first;
      
      final updatedClient = clientToUpdate.copyWith(name: 'João Updated');
      await datasource.update(updatedClient);
      
      final currentClients = await datasource.getAll();
      expect(currentClients.first.name, 'João Updated');
    });

    test('Should delete a client by id', () async {
      final clients = await datasource.getAll();
      final clientToDelete = clients.first;
      
      await datasource.delete(clientToDelete.id);
      
      final currentClients = await datasource.getAll();
      expect(currentClients.length, 1);
      expect(currentClients.where((c) => c.id == clientToDelete.id).isEmpty, true);
    });
  });
}
