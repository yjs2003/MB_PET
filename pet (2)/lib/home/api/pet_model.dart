class petModel {
  final String id;
  final String name;
  final String species;

  petModel({
    required this. id,
    required this. name,
    required this. species,
  });

  factory petModel.fromJson(Map<String, dynamic> json) {
    return petModel(
      id: json["id"],
      name: json["name"],
      species: json["species"],
    );
  }
}