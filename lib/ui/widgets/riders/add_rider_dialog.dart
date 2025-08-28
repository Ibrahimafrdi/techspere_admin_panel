import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/data_providers/riders_provider.dart';
import 'package:kabir_admin_panel/core/models/rider.dart';
import 'package:provider/provider.dart';

class AddRiderDialog extends StatelessWidget {
  AddRiderDialog({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RidersProvider>(builder: (context, ridersProvider, child) {
      return AlertDialog(
        title: const Text('Add New Rider'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ridersProvider.addRider(Rider(
                id: null,
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
              ));
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      );
    });
  }
}
