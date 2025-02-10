import 'package:flutter/material.dart';
import 'package:pet_adoption/views/home/pet_card.dart';
import 'package:pet_adoption/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import '../../blocs/pet/pet_bloc.dart';

class PetGridView extends StatelessWidget {

  const PetGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, provider, child) {
        if (provider.pets.isEmpty) {
          return const ShimmerLoader();
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: provider.pets.length,
          itemBuilder: (context, index) {
            final pet = provider.pets[index];
            return PetCard(pet: pet);
          },
        );
      },
    );
  }
}


