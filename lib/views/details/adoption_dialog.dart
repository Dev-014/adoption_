import 'package:flutter/material.dart';
import '../../models/pet.dart';

class AdoptionConfirmationDialog extends StatelessWidget {
  final Pet pet;

  const AdoptionConfirmationDialog({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Adoption'),
      content: Text('Are you sure you want to adopt ${pet.name}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
