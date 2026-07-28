import 'package:flutter/material.dart';
import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/application/helpers/currency_helper.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pegando o pedido passado via argumentos de rota
    final order = ModalRoute.of(context)?.settings.arguments as OrderModel?;

    if (order == null) {
      return const Scaffold(
        body: Center(child: Text('Pedido não encontrado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido #${order.id.substring(0, 8)}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações do Cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Nome: ${order.client.name}'),
            Text('E-mail: ${order.client.email}'),
            Text('Telefone: ${order.client.phone}'),
            const Divider(height: 32),
            const Text(
              'Itens do Pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 16,
                    columns: const [
                      DataColumn(label: Text('Produto')),
                      DataColumn(label: Text('Qtd'), numeric: true),
                      DataColumn(label: Text('Preço Unitário'), numeric: true),
                      DataColumn(label: Text('Subtotal'), numeric: true),
                    ],
                    rows: order.items.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item.product.name)),
                          DataCell(Text('${item.quantity}')),
                          DataCell(Text(CurrencyHelper.format(item.product.price))),
                          DataCell(Text(
                            CurrencyHelper.format(item.total),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Valor Total Geral:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    CurrencyHelper.format(order.totalAmount),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
