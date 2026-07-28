import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository.dart';
import 'package:vendas_app/src/models/client_model.dart';

class ClientViewModel extends ChangeNotifier {
  final ClientRepository _repository;

  List<ClientModel> _clients = [];
  bool _isLoading = true;
  StreamSubscription<List<ClientModel>>? _subscription;

  ClientViewModel(this._repository) {
    _initReactivity();
  }

  List<ClientModel> get clients => _clients;
  bool get isLoading => _isLoading;

  void _initReactivity() {
    _isLoading = true;
    notifyListeners();

    _subscription = _repository.watchAll().listen(
      (clients) {
        _clients = List.from(clients);
        _clients.sort((a, b) => a.name.compareTo(b.name));
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadClients() async {
    _isLoading = true;
    notifyListeners();

    _clients = List.from(await _repository.getAll());
    _clients.sort((a, b) => a.name.compareTo(b.name));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addClient(ClientModel client) async {
    await _repository.add(client);
  }

  Future<void> updateClient(ClientModel client) async {
    await _repository.update(client);
  }

  Future<void> deleteClient(String id) async {
    await _repository.delete(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
