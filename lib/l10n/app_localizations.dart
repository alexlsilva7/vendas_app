import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('es'), Locale('pt')];

  /// The title of the application shown in the app bar
  ///
  /// In en, this message translates to:
  /// **'Vendas App'**
  String get appTitle;

  /// Tooltip or label for the search action
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Message displayed when the product list is empty
  ///
  /// In en, this message translates to:
  /// **'No products registered.'**
  String get noProducts;

  /// Filter chip label to show all products
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Filter chip label to show only favorite products
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Label for the dark mode toggle in the drawer
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Navigation label for the Home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Navigation label for the Clients screen
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// Navigation label for the Products screen
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Navigation label for the Categories screen
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Navigation label for the Orders screen
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// Tooltip or button label to add a new product
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// Snackbar message shown while adding mock products
  ///
  /// In en, this message translates to:
  /// **'Adding demo products...'**
  String get demoProductsAdding;

  /// Snackbar message shown after successfully adding mock products
  ///
  /// In en, this message translates to:
  /// **'Several demo products added!'**
  String get demoProductsAdded;

  /// Tooltip for the sort action in the products screen
  ///
  /// In en, this message translates to:
  /// **'Sort Products'**
  String get sortProducts;

  /// Dialog title for selecting a sorting method
  ///
  /// In en, this message translates to:
  /// **'Sort by:'**
  String get sortBy;

  /// Option to sort items by name in ascending order
  ///
  /// In en, this message translates to:
  /// **'Name (A-Z)'**
  String get nameAZ;

  /// Option to sort items by name in descending order
  ///
  /// In en, this message translates to:
  /// **'Name (Z-A)'**
  String get nameZA;

  /// Option to sort items by price in ascending order
  ///
  /// In en, this message translates to:
  /// **'Price (Low to High)'**
  String get priceLowHigh;

  /// Option to sort items by price in descending order
  ///
  /// In en, this message translates to:
  /// **'Price (High to Low)'**
  String get priceHighLow;

  /// Title for the screen to create a new product
  ///
  /// In en, this message translates to:
  /// **'New Product'**
  String get newProduct;

  /// Label for the product name input field
  ///
  /// In en, this message translates to:
  /// **'Product Name *'**
  String get productNameLabel;

  /// Validation message when product name is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the product name'**
  String get enterProductName;

  /// Label for the product price input field
  ///
  /// In en, this message translates to:
  /// **'Price *'**
  String get priceLabel;

  /// Validation message when price is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the price'**
  String get enterPrice;

  /// Validation message when price format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid price'**
  String get invalidPrice;

  /// Label for the product category dropdown
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get categoryLabel;

  /// Validation message when no category is selected
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategory;

  /// Label for the image URL input field
  ///
  /// In en, this message translates to:
  /// **'Image URL (Optional)'**
  String get imageUrlLabel;

  /// Button text to save a form
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Success message after saving a product
  ///
  /// In en, this message translates to:
  /// **'Product registered successfully!'**
  String get productSaved;

  /// Title for the screen to create a new client
  ///
  /// In en, this message translates to:
  /// **'New Client'**
  String get newClient;

  /// Tooltip or button label to add a new client
  ///
  /// In en, this message translates to:
  /// **'Add Client'**
  String get addClient;

  /// Snackbar message shown while adding mock clients
  ///
  /// In en, this message translates to:
  /// **'Adding demo clients...'**
  String get demoClientsAdding;

  /// Snackbar message shown after successfully adding mock clients
  ///
  /// In en, this message translates to:
  /// **'Several demo clients added!'**
  String get demoClientsAdded;

  /// Message displayed when the client list is empty
  ///
  /// In en, this message translates to:
  /// **'No clients registered.'**
  String get noClients;

  /// Label for the client full name input field
  ///
  /// In en, this message translates to:
  /// **'Full Name *'**
  String get fullNameLabel;

  /// Validation message when client name is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the client\'s name'**
  String get enterClientName;

  /// Label for the client email input field
  ///
  /// In en, this message translates to:
  /// **'E-mail *'**
  String get emailLabel;

  /// Validation message when email is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the e-mail'**
  String get enterEmail;

  /// Validation message when email format is invalid
  ///
  /// In en, this message translates to:
  /// **'Enter a valid e-mail'**
  String get invalidEmail;

  /// Label for the client phone input field
  ///
  /// In en, this message translates to:
  /// **'Phone *'**
  String get phoneLabel;

  /// Validation message when phone is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the phone'**
  String get enterPhone;

  /// Success message after saving a client
  ///
  /// In en, this message translates to:
  /// **'Client registered successfully!'**
  String get clientSaved;

  /// Tooltip or button label to add a new category
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// Dialog title to create a new category
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get newCategory;

  /// Dialog title to edit an existing category
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// Label for the category name input field
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryNameLabel;

  /// Hint text for the category name input field
  ///
  /// In en, this message translates to:
  /// **'Ex: Electronics, Clothes...'**
  String get categoryNameHint;

  /// Button text to cancel an action or dismiss a dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Dialog title for confirming category deletion
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// Confirmation message body for deleting a category
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the category \"{categoryName}\"?'**
  String confirmDeleteCategory(String categoryName);

  /// Button text to confirm a deletion
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Message displayed when the category list is empty
  ///
  /// In en, this message translates to:
  /// **'No categories registered'**
  String get noCategories;

  /// Button text to remove an item (e.g., from the cart)
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Message showing how many items are in the shopping cart
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item in the cart} other{{count} items in the cart}}'**
  String itemsInCart(int count);

  /// Button text to navigate to the shopping cart screen
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get viewCart;

  /// Message displayed when the shopping cart has no items
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty.'**
  String get emptyCart;

  /// Label for the client selection dropdown in the cart
  ///
  /// In en, this message translates to:
  /// **'Client *'**
  String get clientSelectLabel;

  /// Hint text for the client selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Select a client'**
  String get selectAClient;

  /// Label for the overall total price
  ///
  /// In en, this message translates to:
  /// **'Total Amount:'**
  String get totalAmount;

  /// Button text to finalize an order
  ///
  /// In en, this message translates to:
  /// **'CHECKOUT'**
  String get checkout;

  /// Success message after an order is placed
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully!'**
  String get orderSuccess;

  /// Error message when trying to checkout with an empty cart
  ///
  /// In en, this message translates to:
  /// **'Empty cart.'**
  String get errorEmptyCart;

  /// Error message when trying to checkout without selecting a client
  ///
  /// In en, this message translates to:
  /// **'Select a client to finish the order.'**
  String get errorNoClient;

  /// Title for the completed orders screen
  ///
  /// In en, this message translates to:
  /// **'Completed Orders'**
  String get completedOrders;

  /// Message displayed when the order list is empty
  ///
  /// In en, this message translates to:
  /// **'No orders placed.'**
  String get noOrders;

  /// Label for the client name in a list item
  ///
  /// In en, this message translates to:
  /// **'Client:'**
  String get clientDetailsLabel;

  /// Label for the date in a list item
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get dateLabel;

  /// Title for the order details showing the order ID
  ///
  /// In en, this message translates to:
  /// **'Order #{orderId}'**
  String orderNumber(String orderId);

  /// Section header for client details in an order
  ///
  /// In en, this message translates to:
  /// **'Client Information'**
  String get clientInfo;

  /// Label for the client's name
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get nameLabel;

  /// Label for the client's email
  ///
  /// In en, this message translates to:
  /// **'E-mail:'**
  String get emailDetailsLabel;

  /// Label for the client's phone number
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phoneDetailsLabel;

  /// Section header for the items purchased in an order
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// Column header for the product name in the order items table
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productColumn;

  /// Column header for the quantity in the order items table
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qtyColumn;

  /// Column header for the unit price in the order items table
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPriceColumn;

  /// Column header for the subtotal in the order items table
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotalColumn;

  /// Label for the grand total at the bottom of the order details
  ///
  /// In en, this message translates to:
  /// **'Grand Total:'**
  String get grandTotalLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
