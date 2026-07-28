// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Vendas App';

  @override
  String get search => 'Buscar';

  @override
  String get noProducts => 'No hay productos registrados.';

  @override
  String get all => 'Todos';

  @override
  String get favorites => 'Favoritos';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get home => 'Inicio';

  @override
  String get clients => 'Clientes';

  @override
  String get products => 'Productos';

  @override
  String get categories => 'Categorías';

  @override
  String get orders => 'Pedidos';

  @override
  String get addProduct => 'Añadir Producto';

  @override
  String get demoProductsAdding => 'Añadiendo productos de demostración...';

  @override
  String get demoProductsAdded => '¡Varios productos de demostración añadidos!';

  @override
  String get sortProducts => 'Ordenar Productos';

  @override
  String get sortBy => 'Ordenar por:';

  @override
  String get nameAZ => 'Nombre (A-Z)';

  @override
  String get nameZA => 'Nombre (Z-A)';

  @override
  String get priceLowHigh => 'Precio (Menor a Mayor)';

  @override
  String get priceHighLow => 'Precio (Mayor a Menor)';

  @override
  String get newProduct => 'Nuevo Producto';

  @override
  String get productNameLabel => 'Nombre del Producto *';

  @override
  String get enterProductName => 'Ingrese el nombre del producto';

  @override
  String get priceLabel => 'Precio *';

  @override
  String get enterPrice => 'Ingrese el precio';

  @override
  String get invalidPrice => 'Precio inválido';

  @override
  String get categoryLabel => 'Categoría *';

  @override
  String get selectCategory => 'Seleccione una categoría';

  @override
  String get imageUrlLabel => 'URL de la Imagen (Opcional)';

  @override
  String get save => 'Guardar';

  @override
  String get productSaved => '¡Producto registrado con éxito!';

  @override
  String get newClient => 'Nuevo Cliente';

  @override
  String get addClient => 'Añadir Cliente';

  @override
  String get demoClientsAdding => 'Añadiendo clientes de demostración...';

  @override
  String get demoClientsAdded => '¡Varios clientes de demostración añadidos!';

  @override
  String get noClients => 'No hay clientes registrados.';

  @override
  String get fullNameLabel => 'Nombre Completo *';

  @override
  String get enterClientName => 'Ingrese el nombre del cliente';

  @override
  String get emailLabel => 'Correo electrónico *';

  @override
  String get enterEmail => 'Ingrese el correo electrónico';

  @override
  String get invalidEmail => 'Ingrese un correo electrónico válido';

  @override
  String get phoneLabel => 'Teléfono *';

  @override
  String get enterPhone => 'Ingrese el teléfono';

  @override
  String get clientSaved => '¡Cliente registrado con éxito!';

  @override
  String get addCategory => 'Añadir Categoría';

  @override
  String get newCategory => 'Nueva Categoría';

  @override
  String get editCategory => 'Editar Categoría';

  @override
  String get categoryNameLabel => 'Nombre de la Categoría';

  @override
  String get categoryNameHint => 'Ej: Electrónica, Ropa...';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteCategory => 'Eliminar Categoría';

  @override
  String confirmDeleteCategory(String categoryName) {
    return '¿Realmente desea eliminar la categoría \"$categoryName\"?';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get noCategories => 'No hay categorías registradas';

  @override
  String get remove => 'Eliminar';

  @override
  String itemsInCart(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artículos en el carrito',
      one: '1 artículo en el carrito',
    );
    return '$_temp0';
  }

  @override
  String get viewCart => 'Ver Carrito';

  @override
  String get emptyCart => 'Su carrito está vacío.';

  @override
  String get clientSelectLabel => 'Cliente *';

  @override
  String get selectAClient => 'Seleccione un cliente';

  @override
  String get totalAmount => 'Monto Total:';

  @override
  String get checkout => 'FINALIZAR PEDIDO';

  @override
  String get orderSuccess => '¡Pedido realizado con éxito!';

  @override
  String get errorEmptyCart => 'Carrito vacío.';

  @override
  String get errorNoClient => 'Seleccione un cliente para finalizar el pedido.';

  @override
  String get completedOrders => 'Pedidos Realizados';

  @override
  String get noOrders => 'No se han realizado pedidos.';

  @override
  String get clientDetailsLabel => 'Cliente:';

  @override
  String get dateLabel => 'Fecha:';

  @override
  String orderNumber(String orderId) {
    return 'Pedido #$orderId';
  }

  @override
  String get clientInfo => 'Información del Cliente';

  @override
  String get nameLabel => 'Nombre:';

  @override
  String get emailDetailsLabel => 'Correo electrónico:';

  @override
  String get phoneDetailsLabel => 'Teléfono:';

  @override
  String get orderItems => 'Artículos del Pedido';

  @override
  String get productColumn => 'Producto';

  @override
  String get qtyColumn => 'Cant';

  @override
  String get unitPriceColumn => 'Precio Unitario';

  @override
  String get subtotalColumn => 'Subtotal';

  @override
  String get grandTotalLabel => 'Monto Total General:';
}
