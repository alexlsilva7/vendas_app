# Vendas App

Aplicativo Flutter para gerenciamento de vendas. O projeto reúne cadastro de
clientes, produtos e categorias, criação de pedidos por meio de um carrinho e
consulta ao histórico de vendas.

## Funcionalidades

- CRUD de clientes;
- CRUD de produtos, com categoria, preço e imagem;
- cadastro e listagem de categorias;
- catálogo de produtos com ordenação;
- carrinho com alteração de quantidades e seleção opcional de cliente;
- finalização e persistência de pedidos;
- histórico e detalhes dos pedidos realizados;
- alternância entre os temas claro e escuro.

As páginas administrativas de clientes e produtos são independentes do
carrinho. A inclusão de itens em uma venda ocorre pelo catálogo da página
inicial.

## Arquitetura

O projeto separa as responsabilidades nas seguintes camadas:

- `models`: entidades e conversão dos dados;
- `data/datasources`: contratos e implementações de acesso local;
- `data/repositories`: abstração entre os dados e a aplicação;
- `features`: páginas, widgets e `ChangeNotifier`s de cada funcionalidade;
- `services`: inicialização e acesso aos serviços compartilhados.

O gerenciamento de estado e a injeção das dependências são realizados com
Provider. As dependências principais são configuradas em
`lib/src/dependencies.dart`.

## Persistência

Clientes, produtos, categorias e pedidos são armazenados localmente com
Couchbase Lite. A inicialização do banco acontece antes da execução do
aplicativo.

O projeto também mantém DataSources em memória para testes automatizados e
previews de widgets.

## Tecnologias principais

- Flutter e Dart;
- Provider;
- Couchbase Lite;
- `intl` para formatação;
- `reel_text` para transições textuais pontuais no carrinho;
- Mocktail e Flutter Test.

## Como executar

É necessário ter um Flutter SDK compatível com Dart `^3.10.4`.

```bash
flutter pub get
flutter run
```

## Verificação

```bash
flutter analyze
flutter test
```
