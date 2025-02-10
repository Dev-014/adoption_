import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../blocs/adoption/adoption_history_bloc.dart';
// import '../../blocs/pet/pet_bloc.dart';
// import '../../models/pet.dart';
// import 'adoption_dialog.dart';
//
// class AdoptionButton extends StatelessWidget {
//   final Pet pet;
//
//   const AdoptionButton({super.key, required this.pet});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: pet.isAdopted ? null : () => _adoptPet(context),
//       child: Text(pet.isAdopted ? 'Already Adopted' : 'Adopt Me'),
//     );
//   }
//
//   void _adoptPet(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AdoptionConfirmationDialog(pet: pet),
//     ).then((confirmed) {
//       if (confirmed) {
//         context.read<PetProvider>().adoptPet(pet.id);
//         context.read<AdoptionHistoryProvider>().addAdoption(pet);
//       }
//     });
//   }
// }

import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';

import '../../blocs/adoption/adoption_history_bloc.dart';
import '../../blocs/pet/pet_bloc.dart';
import '../../models/pet.dart';

class AdoptionButton extends StatefulWidget {
  final Pet pet;

  const AdoptionButton({super.key, required this.pet});

  @override
  State<AdoptionButton> createState() => _AdoptionButtonState();
}

class _AdoptionButtonState extends State<AdoptionButton> {
  final _confettiController = ConfettiController(duration: const Duration(seconds: 1));

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: widget.pet.isAdopted ? null : _showAdoptionDialog,
            child: Text(
              widget.pet.isAdopted ? 'Already Adopted' : 'Adopt Me',
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ),
      ],
    );
  }

  void _showAdoptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adopt ${widget.pet.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to adopt this pet?'),
            if (widget.pet.price > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Adoption fee: \$${widget.pet.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _confettiController.play();
              context.read<PetProvider>().adoptPet(widget.pet.id);
              context.read<AdoptionHistoryProvider>().addAdoption(widget.pet);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Congratulations! You adopted ${widget.pet.name}'),
                ),
              );
            },
            child: const Text('Adopt'),
          ),
        ],
      ),
    );
  }
}