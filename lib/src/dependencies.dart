import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendas_app/src/data/datasources/local/category/category_couchbase_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_couchbase_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_couchbase_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_couchbase_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/settings/settings_viewmodel.dart';
import 'package:vendas_app/src/services/couchbase_service.dart';

class AppDependencies {
  static late CouchbaseService couchbaseService;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await CouchbaseLiteFlutter.init();

    couchbaseService = CouchbaseService();
    await couchbaseService.init();
  }

  static List<SingleChildWidget> get providers {
    // Inicialização de DataSources
    final clientDatasource = ClientCouchbaseLocalDatasource(couchbaseService);
    final productDatasource = ProductCouchbaseLocalDatasource(couchbaseService);
    final orderDatasource = OrderCouchbaseLocalDatasource(couchbaseService);
    final categoryDatasource = CategoryCouchbaseLocalDatasource(couchbaseService);

    // Inicialização de Repositories
    final clientRepository = ClientRepositoryImpl(clientDatasource);
    final productRepository = ProductRepositoryImpl(productDatasource);
    final orderRepository = OrderRepositoryImpl(orderDatasource);
    final categoryRepository = CategoryRepositoryImpl(categoryDatasource);

    return [
      ChangeNotifierProvider(
        create: (_) => ClientViewModel(clientRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryViewModel(categoryRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductViewModel(productRepository, categoryRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderViewModel(orderRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => CartViewModel(orderRepository),
      ),
      ChangeNotifierProvider(
        create: (_) => SettingsViewModel(),
      ),
    ];
  }
}
