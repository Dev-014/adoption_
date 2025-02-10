import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/adoption_history.dart';
import '../../models/pet.dart';

class AdoptionHistoryProvider with ChangeNotifier {
  List<AdoptionHistory> _history = [];

  List<AdoptionHistory> get history => _history;

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('adoption_history') ?? [];

    _history = historyJson.map((json) {
      final data = jsonDecode(json);
      return AdoptionHistory(
        petId: data['petId'],
        petName: data['petName'],
        adoptionDate: DateTime.parse(data['adoptionDate']),
        imageUrl: data['imageUrl'],
      );
    }).toList();

    notifyListeners();
  }

  Future<void> addAdoption(Pet pet) async {
    final newEntry = AdoptionHistory(
      petId: pet.id,
      petName: pet.name,
      adoptionDate: DateTime.now(),
      imageUrl: pet.imageUrl,
    );

    _history.insert(0, newEntry);
    await _saveHistory();
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = _history.map((entry) => jsonEncode({
      'petId': entry.petId,
      'petName': entry.petName,
      'adoptionDate': entry.adoptionDate.toIso8601String(),
      'imageUrl': entry.imageUrl,
    })).toList();

    await prefs.setStringList('adoption_history', historyJson);
  }

  Future<void> clearHistory() async {
    _history.clear();
    await _saveHistory();
    notifyListeners();
  }
}