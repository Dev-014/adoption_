import 'package:intl/intl.dart';

class AdoptionHistory {
  final String petId;
  final String petName;
  final DateTime adoptionDate;
  final String imageUrl;

  AdoptionHistory({
    required this.petId,
    required this.petName,
    required this.adoptionDate,
    required this.imageUrl,
  });

  String get formattedDate => DateFormat('MMM dd, yyyy - hh:mm a').format(adoptionDate);
}