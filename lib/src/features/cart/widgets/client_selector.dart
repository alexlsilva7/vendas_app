import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';

class ClientSelector extends StatelessWidget {
  const ClientSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    final clientViewModel = context.watch<ClientViewModel>();
    final theme = Theme.of(context);

    return DropdownButtonFormField<ClientModel>(
      decoration: InputDecoration(
        labelText: 'Cliente *',
        prefixIcon: Icon(Icons.person_outline, color: theme.colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      ),
      initialValue: cartViewModel.selectedClient,
      hint: const Text('Selecione um cliente'),
      items: clientViewModel.clients.map((client) {
        return DropdownMenuItem<ClientModel>(
          value: client,
          child: Text(client.name),
        );
      }).toList(),
      onChanged: (client) {
        if (client != null) {
          cartViewModel.selectClient(client);
        }
      },
    );
  }
}
