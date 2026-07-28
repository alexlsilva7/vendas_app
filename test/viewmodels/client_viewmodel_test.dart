import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';

class MockClientRepository extends Mock implements ClientRepository {}

class FakeClientModel extends Fake implements ClientModel {}

void main() {
  late ClientViewModel viewModel;
  late MockClientRepository mockRepository;
  late StreamController<List<ClientModel>> clientStreamController;

  setUpAll(() {
    registerFallbackValue(FakeClientModel());
  });

  setUp(() {
    mockRepository = MockClientRepository();
    clientStreamController = StreamController<List<ClientModel>>.broadcast();
    when(() => mockRepository.watchAll()).thenAnswer((_) => clientStreamController.stream);
    viewModel = ClientViewModel(mockRepository);
  });

  tearDown(() {
    clientStreamController.close();
  });

  group('ClientViewModel Tests', () {
    final tClient = ClientModel(name: 'Test', email: 'test@test.com', phone: '123');
    final tClientsList = [tClient];

    test('should update clients list reactively when watchAll emits', () async {
      expect(viewModel.clients, isEmpty);
      clientStreamController.add(tClientsList);
      await pumpEventQueue();
      expect(viewModel.clients, tClientsList);
      expect(viewModel.isLoading, false);
    });

    test('loadClients should set isLoading and update clients list', () async {
      when(() => mockRepository.getAll()).thenAnswer((_) async => tClientsList);

      final future = viewModel.loadClients();
      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
      expect(viewModel.clients, tClientsList);
      verify(() => mockRepository.getAll()).called(1);
    });

    test('addClient should call repository', () async {
      when(() => mockRepository.add(any())).thenAnswer((_) async {});

      await viewModel.addClient(tClient);

      verify(() => mockRepository.add(any())).called(1);
    });

    test('updateClient should update repository', () async {
      when(() => mockRepository.update(any())).thenAnswer((_) async {});

      await viewModel.updateClient(tClient);

      verify(() => mockRepository.update(tClient)).called(1);
    });

    test('deleteClient should delete from repository', () async {
      when(() => mockRepository.delete(any())).thenAnswer((_) async {});

      await viewModel.deleteClient(tClient.id);

      verify(() => mockRepository.delete(tClient.id)).called(1);
    });
  });
}

