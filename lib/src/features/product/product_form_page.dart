import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/models/product_model.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key, this.product});

  final ProductModel? product;

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;
  final _imageUrlController = TextEditingController();

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();

    final product = widget.product;
    if (product != null) {
      _nameController.text = product.name;
      _priceController.text = product.price.toStringAsFixed(2);
      _selectedCategory = product.category;
      _imageUrlController.text = product.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final categoryViewModel = context.read<CategoryViewModel>();
      final categories = categoryViewModel.categories;
      final category = _selectedCategory ?? (categories.isNotEmpty ? categories.first.name : 'Geral');

      final productViewModel = context.read<ProductViewModel>();
      final name = _nameController.text.trim();
      final price = double.parse(_priceController.text.trim().replaceFirst(',', '.'));
      final imageUrl = _imageUrlController.text.trim();

      if (_isEditing) {
        await productViewModel.updateProduct(
          widget.product!.copyWith(
            name: name,
            price: price,
            category: category,
            imageUrl: imageUrl,
          ),
        );
      } else {
        await productViewModel.addProduct(
          ProductModel(
            name: name,
            price: price,
            category: category,
            imageUrl: imageUrl,
          ),
        );
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Produto atualizado com sucesso!' : 'Produto cadastrado com sucesso!',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Produto' : 'Novo Produto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do Produto *'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Preço *',
                  prefixText: 'R\$ ',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira o preço';
                  }
                  if (double.tryParse(value.replaceFirst(',', '.')) == null) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Consumer<CategoryViewModel>(
                builder: (context, categoryViewModel, child) {
                  final categories = categoryViewModel.categories;
                  final currentSelected = categories.any((c) => c.name == _selectedCategory)
                      ? _selectedCategory
                      : (categories.isNotEmpty ? categories.first.name : null);

                  return DropdownButtonFormField<String>(
                    initialValue: currentSelected,
                    decoration: const InputDecoration(labelText: 'Categoria *'),
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.name,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Selecione uma categoria';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL da Imagem (Opcional)'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
