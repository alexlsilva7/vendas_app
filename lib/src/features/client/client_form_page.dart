import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({super.key, this.client});

  final ClientModel? client;

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool get _isEditing => widget.client != null;

  @override
  void initState() {
    super.initState();

    final client = widget.client;
    if (client != null) {
      _nameController.text = client.name;
      _emailController.text = client.email;
      _phoneController.text = client.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final clientViewModel = context.read<ClientViewModel>();
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = _phoneController.text.trim();

      if (_isEditing) {
        await clientViewModel.updateClient(
          widget.client!.copyWith(
            name: name,
            email: email,
            phone: phone,
          ),
        );
      } else {
        await clientViewModel.addClient(
          ClientModel(name: name, email: email, phone: phone),
        );
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Cliente atualizado com sucesso!' : 'Cliente cadastrado com sucesso!',
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
        title: Text(_isEditing ? 'Editar Cliente' : 'Novo Cliente'),
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
                decoration: const InputDecoration(labelText: 'Nome Completo *'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira o nome do cliente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail *'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira o e-mail';
                  }
                  if (!value.contains('@')) {
                    return 'Insira um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone *'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira o telefone';
                  }
                  return null;
                },
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
