// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Vendas App';

  @override
  String get search => 'Search';

  @override
  String get noProducts => 'No products registered.';

  @override
  String get all => 'All';

  @override
  String get favorites => 'Favorites';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get home => 'Home';

  @override
  String get clients => 'Clients';

  @override
  String get products => 'Products';

  @override
  String get categories => 'Categories';

  @override
  String get orders => 'Orders';

  @override
  String get addProduct => 'Add Product';

  @override
  String get demoProductsAdding => 'Adding demo products...';

  @override
  String get demoProductsAdded => 'Several demo products added!';

  @override
  String get sortProducts => 'Sort Products';

  @override
  String get sortBy => 'Sort by:';

  @override
  String get nameAZ => 'Name (A-Z)';

  @override
  String get nameZA => 'Name (Z-A)';

  @override
  String get priceLowHigh => 'Price (Low to High)';

  @override
  String get priceHighLow => 'Price (High to Low)';

  @override
  String get newProduct => 'New Product';

  @override
  String get productNameLabel => 'Product Name *';

  @override
  String get enterProductName => 'Enter the product name';

  @override
  String get priceLabel => 'Price *';

  @override
  String get enterPrice => 'Enter the price';

  @override
  String get invalidPrice => 'Invalid price';

  @override
  String get categoryLabel => 'Category *';

  @override
  String get selectCategory => 'Select a category';

  @override
  String get imageUrlLabel => 'Image URL (Optional)';

  @override
  String get save => 'Save';

  @override
  String get productSaved => 'Product registered successfully!';

  @override
  String get newClient => 'New Client';

  @override
  String get addClient => 'Add Client';

  @override
  String get demoClientsAdding => 'Adding demo clients...';

  @override
  String get demoClientsAdded => 'Several demo clients added!';

  @override
  String get noClients => 'No clients registered.';

  @override
  String get fullNameLabel => 'Full Name *';

  @override
  String get enterClientName => 'Enter the client\'s name';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get enterEmail => 'Enter the e-mail';

  @override
  String get invalidEmail => 'Enter a valid e-mail';

  @override
  String get phoneLabel => 'Phone *';

  @override
  String get enterPhone => 'Enter the phone';

  @override
  String get clientSaved => 'Client registered successfully!';

  @override
  String get addCategory => 'Add Category';

  @override
  String get newCategory => 'New Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get categoryNameLabel => 'Category Name';

  @override
  String get categoryNameHint => 'Ex: Electronics, Clothes...';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Do you really want to delete the category \"$categoryName\"?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get noCategories => 'No categories registered';

  @override
  String get remove => 'Remove';

  @override
  String itemsInCart(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items in the cart',
      one: '1 item in the cart',
    );
    return '$_temp0';
  }

  @override
  String get viewCart => 'View Cart';

  @override
  String get emptyCart => 'Your cart is empty.';

  @override
  String get clientSelectLabel => 'Client *';

  @override
  String get selectAClient => 'Select a client';

  @override
  String get totalAmount => 'Total Amount:';

  @override
  String get checkout => 'CHECKOUT';

  @override
  String get orderSuccess => 'Order placed successfully!';

  @override
  String get errorEmptyCart => 'Empty cart.';

  @override
  String get errorNoClient => 'Select a client to finish the order.';

  @override
  String get completedOrders => 'Completed Orders';

  @override
  String get noOrders => 'No orders placed.';

  @override
  String get clientDetailsLabel => 'Client:';

  @override
  String get dateLabel => 'Date:';

  @override
  String orderNumber(String orderId) {
    return 'Order #$orderId';
  }

  @override
  String get clientInfo => 'Client Information';

  @override
  String get nameLabel => 'Name:';

  @override
  String get emailDetailsLabel => 'E-mail:';

  @override
  String get phoneDetailsLabel => 'Phone:';

  @override
  String get orderItems => 'Order Items';

  @override
  String get productColumn => 'Product';

  @override
  String get qtyColumn => 'Qty';

  @override
  String get unitPriceColumn => 'Unit Price';

  @override
  String get subtotalColumn => 'Subtotal';

  @override
  String get grandTotalLabel => 'Grand Total:';
}
