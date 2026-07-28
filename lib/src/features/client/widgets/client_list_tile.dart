import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:vendas_app/src/models/client_model.dart';

class ClientListTile extends StatelessWidget {
  final ClientModel client;
  const ClientListTile({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(client.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(client.email),
          Text(client.phone),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(context, '/clients/form', arguments: client);
        },
      ),
    );
  }
}

@Preview(name: 'ClientListTile', group: 'client', size: Size(400, 100))
Widget previewClientListTile() {
  return ClientListTile(
    client: ClientModel(name: 'John Doe', email: 'john.doe@email.com', phone: '(11) 99999-9999'),
  );
}
