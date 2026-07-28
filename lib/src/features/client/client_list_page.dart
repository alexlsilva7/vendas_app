import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/client/widgets/client_list_card.dart';
import 'package:vendas_app/src/models/client_model.dart';

class ClientListPage extends StatelessWidget {
  const ClientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientViewModel = context.watch<ClientViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/clients/form'),
            tooltip: 'Adicionar cliente',
          ),
        ],
      ),
      body: clientViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : clientViewModel.clients.isEmpty
          ? const Center(child: Text('Nenhum cliente cadastrado.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: clientViewModel.clients.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final client = clientViewModel.clients[index];

                return ClientListCard(
                  client: client,
                  onEdit: () => Navigator.pushNamed(
                    context,
                    '/clients/form',
                    arguments: client,
                  ),
                  onDelete: () => _confirmDelete(
                    context,
                    clientViewModel,
                    client,
                  ),
                );
              },
            ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ClientViewModel viewModel,
    ClientModel client,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir cliente'),
        content: Text('Deseja excluir "${client.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (shouldDelete != true) {
      return;
    }

    await viewModel.deleteClient(client.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente excluído com sucesso!')),
    );
  }
}
