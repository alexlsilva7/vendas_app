import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';
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
            onLongPress: () async {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('Adicionando clientes de demonstracao...'),
                  duration: Duration(seconds: 1),
                ),
              );

              final staticClients = [
                ClientModel(
                  name: 'Joao Silva',
                  email: 'joao.silva@email.com',
                  phone: '(11) 98765-4321',
                ),
                ClientModel(
                  name: 'Maria Souza',
                  email: 'maria.souza@email.com',
                  phone: '(21) 97654-3210',
                ),
                ClientModel(
                  name: 'Carlos Oliveira',
                  email: 'carlos.oliveira@email.com',
                  phone: '(31) 96543-2109',
                ),
                ClientModel(
                  name: 'Ana Costa',
                  email: 'ana.costa@email.com',
                  phone: '(41) 95432-1098',
                ),
                ClientModel(
                  name: 'Lucas Santos',
                  email: 'lucas.santos@email.com',
                  phone: '(51) 94321-0987',
                ),
                ClientModel(
                  name: 'Beatriz Pereira',
                  email: 'beatriz.pereira@email.com',
                  phone: '(61) 93210-9876',
                ),
                ClientModel(
                  name: 'Fernando Lima',
                  email: 'fernando.lima@email.com',
                  phone: '(71) 92109-8765',
                ),
                ClientModel(
                  name: 'Juliana Martins',
                  email: 'juliana.martins@email.com',
                  phone: '(81) 91098-7654',
                ),
                ClientModel(
                  name: 'Gabriel Barbosa',
                  email: 'gabriel.barbosa@email.com',
                  phone: '(91) 90987-6543',
                ),
                ClientModel(
                  name: 'Amanda Ribeiro',
                  email: 'amanda.ribeiro@email.com',
                  phone: '(19) 98877-6655',
                ),
              ];

              for (final client in staticClients) {
                await clientViewModel.addClient(client);
              }

              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('Varios clientes de demonstracao adicionados!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            tooltip: 'Adicionar Cliente',
          ),
        ],
      ),
      body: clientViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : clientViewModel.clients.isEmpty
              ? const Center(child: Text('Nenhum cliente cadastrado.'))
              : ListView.builder(
                  itemCount: clientViewModel.clients.length,
                  itemBuilder: (context, index) {
                    final client = clientViewModel.clients[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(client.name.substring(0, 1).toUpperCase()),
                      ),
                      title: Text(client.name),
                      subtitle: Text('${client.email} | ${client.phone}'),
                    );
                  },
                ),
      bottomNavigationBar: const CartBottomBanner(),
    );
  }
}
