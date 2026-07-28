// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Vendas App';

  @override
  String get search => 'Pesquisar';

  @override
  String get noProducts => 'Nenhum produto cadastrado.';

  @override
  String get all => 'Todos';

  @override
  String get favorites => 'Favoritos';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get home => 'Home';

  @override
  String get clients => 'Clientes';

  @override
  String get products => 'Produtos';

  @override
  String get categories => 'Categorias';

  @override
  String get orders => 'Pedidos';

  @override
  String get addProduct => 'Adicionar Produto';

  @override
  String get demoProductsAdding => 'Adicionando produtos de demonstração...';

  @override
  String get demoProductsAdded => 'Vários produtos de demonstração adicionados!';

  @override
  String get sortProducts => 'Ordenar Produtos';

  @override
  String get sortBy => 'Ordenar por:';

  @override
  String get nameAZ => 'Nome (A-Z)';

  @override
  String get nameZA => 'Nome (Z-A)';

  @override
  String get priceLowHigh => 'Preço (Menor para Maior)';

  @override
  String get priceHighLow => 'Preço (Maior para Menor)';

  @override
  String get newProduct => 'Novo Produto';

  @override
  String get productNameLabel => 'Nome do Produto *';

  @override
  String get enterProductName => 'Insira o nome do produto';

  @override
  String get priceLabel => 'Preço *';

  @override
  String get enterPrice => 'Insira o preço';

  @override
  String get invalidPrice => 'Preço inválido';

  @override
  String get categoryLabel => 'Categoria *';

  @override
  String get selectCategory => 'Selecione uma categoria';

  @override
  String get imageUrlLabel => 'URL da Imagem (Opcional)';

  @override
  String get save => 'Salvar';

  @override
  String get productSaved => 'Produto cadastrado com sucesso!';

  @override
  String get newClient => 'Novo Cliente';

  @override
  String get addClient => 'Adicionar Cliente';

  @override
  String get demoClientsAdding => 'Adicionando clientes de demonstracao...';

  @override
  String get demoClientsAdded => 'Vários clientes de demonstracao adicionados!';

  @override
  String get noClients => 'Nenhum cliente cadastrado.';

  @override
  String get fullNameLabel => 'Nome Completo *';

  @override
  String get enterClientName => 'Insira o nome do cliente';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get enterEmail => 'Insira o e-mail';

  @override
  String get invalidEmail => 'Insira um e-mail válido';

  @override
  String get phoneLabel => 'Telefone *';

  @override
  String get enterPhone => 'Insira o telefone';

  @override
  String get clientSaved => 'Cliente cadastrado com sucesso!';

  @override
  String get addCategory => 'Adicionar Categoria';

  @override
  String get newCategory => 'Nova Categoria';

  @override
  String get editCategory => 'Editar Categoria';

  @override
  String get categoryNameLabel => 'Nome da Categoria';

  @override
  String get categoryNameHint => 'Ex: Eletrônicos, Roupas...';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteCategory => 'Excluir Categoria';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Deseja realmente excluir a categoria \"$categoryName\"?';
  }

  @override
  String get delete => 'Excluir';

  @override
  String get noCategories => 'Nenhuma categoria cadastrada';

  @override
  String get remove => 'Remover';

  @override
  String itemsInCart(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens no carrinho',
      one: '1 item no carrinho',
    );
    return '$_temp0';
  }

  @override
  String get viewCart => 'Ver Carrinho';

  @override
  String get emptyCart => 'Seu carrinho está vazio.';

  @override
  String get clientSelectLabel => 'Cliente *';

  @override
  String get selectAClient => 'Selecione um cliente';

  @override
  String get totalAmount => 'Valor Total:';

  @override
  String get checkout => 'FINALIZAR PEDIDO';

  @override
  String get orderSuccess => 'Pedido realizado com sucesso!';

  @override
  String get errorEmptyCart => 'Carrinho vazio.';

  @override
  String get errorNoClient => 'Selecione um cliente para finalizar o pedido.';

  @override
  String get completedOrders => 'Pedidos Realizados';

  @override
  String get noOrders => 'Nenhum pedido realizado.';

  @override
  String get clientDetailsLabel => 'Cliente:';

  @override
  String get dateLabel => 'Data:';

  @override
  String orderNumber(String orderId) {
    return 'Pedido #$orderId';
  }

  @override
  String get clientInfo => 'Informações do Cliente';

  @override
  String get nameLabel => 'Nome:';

  @override
  String get emailDetailsLabel => 'E-mail:';

  @override
  String get phoneDetailsLabel => 'Telefone:';

  @override
  String get orderItems => 'Itens do Pedido';

  @override
  String get productColumn => 'Produto';

  @override
  String get qtyColumn => 'Qtd';

  @override
  String get unitPriceColumn => 'Preço Unitário';

  @override
  String get subtotalColumn => 'Subtotal';

  @override
  String get grandTotalLabel => 'Valor Total Geral:';
}
