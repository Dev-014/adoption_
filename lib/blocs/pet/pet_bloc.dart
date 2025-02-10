import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/pet.dart';
import '../../repository/pet_repository.dart';

class PetProvider with ChangeNotifier {
  List<Pet> _pets = [];
  List<Pet> _filteredPets = [];
  String _searchQuery = '';

  List<Pet> get pets => _filteredPets;
  List<Pet> get allPets => _pets;

  PetProvider() {
    loadPets();
  }
  Future<void> loadPets() async {
    final adoptedIds = await LocalStorage.getAdoptedPets();
    _pets = (await PetRepository.getPets()).map((pet) {
      return pet.copyWith(isAdopted: adoptedIds.contains(pet.id));
    }).toList();
    _applyFilters();
    notifyListeners();
  }

  void adoptPet(String petId) async {
    final index = _pets.indexWhere((pet) => pet.id == petId);
    _pets[index] = _pets[index].copyWith(isAdopted: true);
    _applyFilters();
    await LocalStorage.saveAdoptedPets(
        _pets.where((p) => p.isAdopted).map((p) => p.id).toList()
    );
    notifyListeners();
  }
  void searchPets(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredPets = _pets.where((pet) {
      return pet.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void toggleFavorite(String petId) {
    final index = _pets.indexWhere((pet) => pet.id == petId);
    _pets[index] = _pets[index].copyWith(isFavorite: !_pets[index].isFavorite);
    notifyListeners();
  }

}



class LocalStorage {
  static const String _adoptedPetsKey = 'adopted_pets';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();}

  static List<String> getAdoptedPets() {
    return _prefs?.getStringList(_adoptedPetsKey) ?? [];
  }
  static Future<void> saveAdoptedPets(List<String> adoptedIds) async {
    await _prefs?.setStringList(_adoptedPetsKey, adoptedIds);
  }


}
