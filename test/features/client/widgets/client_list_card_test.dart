import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository_impl.dart';
import 'package:vendas_app/src/features/client/client_list_page.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/client/widgets/client_list_card.dart';
import 'package:vendas_app/src/models/client_model.dart';

void main() {
  testWidgets('shows client data and exposes CRUD actions', (tester) async {
    var editPressed = false;
    var deletePressed = false;
    final client = ClientModel(
      name: 'João da Silva',
      email: 'joao@email.com',
      phone: '(11) 99999-9999',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ClientListCard(
            client: client,
            onEdit: () => editPressed = true,
            onDelete: () => deletePressed = true,
          ),
        ),
      ),
    );

    expect(find.text(client.name), findsOneWidget);
    expect(find.text(client.email), findsOneWidget);
    expect(find.text(client.phone), findsOneWidget);

    await tester.tap(find.byTooltip('Editar cliente'));
    await tester.tap(find.byTooltip('Excluir cliente'));

    expect(editPressed, isTrue);
    expect(deletePressed, isTrue);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);
  });

  testWidgets('client page renders a list without cart UI', (tester) async {
    final viewModel = ClientViewModel(
      ClientRepositoryImpl(ClientMemoryLocalDatasource()),
    );
    await viewModel.loadClients();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: viewModel,
        child: const MaterialApp(home: ClientListPage()),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ClientListCard), findsWidgets);
    expect(find.byIcon(Icons.shopping_cart), findsNothing);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);
  });
}
