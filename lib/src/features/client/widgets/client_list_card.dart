import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:vendas_app/src/models/client_model.dart';

class ClientListCard extends StatelessWidget {
  const ClientListCard({
    super.key,
    required this.client,
    required this.onEdit,
    required this.onDelete,
  });

  final ClientModel client;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initial = client.name.trim().isEmpty ? '?' : client.name.trim().substring(0, 1).toUpperCase();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: Text(
                initial,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _ClientDetail(
                    icon: Icons.email_outlined,
                    value: client.email,
                  ),
                  const SizedBox(height: 4),
                  _ClientDetail(
                    icon: Icons.phone_outlined,
                    value: client.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Editar cliente',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                  color: colorScheme.error,
                  tooltip: 'Excluir cliente',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientDetail extends StatelessWidget {
  const _ClientDetail({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

@Preview(name: 'ClientListCard', group: 'client', size: Size(420, 120))
Widget previewClientListCard() {
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ClientListCard(
          client: ClientModel(
            name: 'João da Silva',
            email: 'joao.silva@email.com',
            phone: '(11) 99999-9999',
          ),
          onEdit: () {},
          onDelete: () {},
        ),
      ),
    ),
  );
}
