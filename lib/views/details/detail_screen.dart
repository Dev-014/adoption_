import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/pet/pet_bloc.dart';
import '../../models/pet.dart';
import 'adoption_button.dart';

class DetailScreen extends StatelessWidget {
  final Pet pet;

  const DetailScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            flexibleSpace: Hero(
              tag: pet.id,
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: pet.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPetHeader(context),
                  const SizedBox(height: 16),
                  _buildPetDetails(context),
                  const SizedBox(height: 24),
                  AdoptionButton(pet: pet),
                  const SizedBox(height: 24),
                  _buildAboutSection(),
                  const SizedBox(height: 24),
                  _buildCharacteristics(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                pet.breed,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: pet.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () => _toggleFavorite(context),
        ),
      ],
    );
  }

  Widget _buildPetDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetailItem(Icons.cake, '${pet.age} years'),
          _buildDetailItem(Icons.pets, pet.gender),
          _buildDetailItem(Icons.attach_money, '\$${pet.price}'),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 28),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About ${pet.name}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          pet.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCharacteristics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Characteristics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: pet.characteristics
              .map((char) => Chip(
            label: Text(char),
            backgroundColor: Colors.blue[50],
          ))
              .toList(),
        ),
      ],
    );
  }

  void _toggleFavorite(BuildContext context) {
    context.read<PetProvider>().toggleFavorite(pet.id);
  }
  //
  // void _sharePet(BuildContext context) {
  //   final text = 'Check out ${pet.name}, a ${pet.age} year old ${pet.breed} '
  //       'available for adoption!';
  //
  //   Share.share(
  //     text,
  //     subject: 'Adopt ${pet.name}',
  //   );
  // }
}