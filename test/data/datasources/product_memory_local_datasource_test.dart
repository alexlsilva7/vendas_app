import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_memory_local_datasource.dart';
import 'package:vendas_app/src/models/product_model.dart';

void main() {
  late ProductMemoryLocalDatasource datasource;

  setUp(() {
    datasource = ProductMemoryLocalDatasource();
  });

  group('ProductMemoryLocalDatasource Tests', () {
    test('Should initialize with five mocked products', () async {
      final products = await datasource.getAll();
      expect(products.length, 5);
      expect(products.first.name, 'Notebook');
    });

    test('Should watchAll stream and emit updates when products are added', () async {
      final stream = datasource.watchAll();
      final emits = <List<ProductModel>>[];
      
      final sub = stream.listen(emits.add);
      
      // Wait for the microtask to run and add the initial list
      await Future.delayed(Duration.zero);
      expect(emits.length, 1);
      expect(emits[0].length, 5);
      
      final newProduct = ProductModel(name: 'New Product', price: 15.0, imageUrl: '');
      await datasource.add(newProduct);
      
      // Wait for the stream controller to process the event
      await Future.delayed(Duration.zero);
      
      expect(emits.length, 2);
      expect(emits[1].length, 6);
      expect(emits[1].last.name, 'New Product');
      
      await sub.cancel();
    });

    test('Should add a new product', () async {
      final newProduct = ProductModel(name: 'Teste', price: 10.0, imageUrl: '');
      await datasource.add(newProduct);
      
      final products = await datasource.getAll();
      expect(products.length, 6);
      expect(products.last.id, newProduct.id);
    });

    test('Should update an existing product', () async {
      final products = await datasource.getAll();
      final productToUpdate = products.first;
      
      final updatedProduct = productToUpdate.copyWith(name: 'Updated');
      await datasource.update(updatedProduct);
      
      final currentProducts = await datasource.getAll();
      expect(currentProducts.first.name, 'Updated');
    });

    test('Should delete a product by id', () async {
      final products = await datasource.getAll();
      final productToDelete = products.first;
      
      await datasource.delete(productToDelete.id);
      
      final currentProducts = await datasource.getAll();
      expect(currentProducts.length, 4);
      expect(currentProducts.where((p) => p.id == productToDelete.id).isEmpty, true);
    });
  });
}
