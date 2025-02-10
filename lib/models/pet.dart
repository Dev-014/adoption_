class Pet {
  final String id;
  final String name;
  final String breed;
  final int age;
  final double price;
  final String imageUrl;
  final String gender;
  final String description;
  final List<String> characteristics;
  bool isAdopted;
  bool isFavorite;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.price,
    required this.imageUrl,
    required this.gender,
    required this.description,
    required this.characteristics,
    this.isAdopted = false,
    this.isFavorite = false,
  });

  Pet copyWith({
    bool? isAdopted,
    bool? isFavorite,
  }) {
    return Pet(
      id: id,
      name: name,
      breed: breed,
      age: age,
      price: price,
      imageUrl: imageUrl,
      gender: gender,
      description: description,
      characteristics: characteristics,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}