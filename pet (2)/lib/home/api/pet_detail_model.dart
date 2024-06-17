class petDetailModel {
  final String id;
  final String name;
  final String species;
  final String age;
  final String gender;


  petDetailModel({
    required this. id,
    required this. name,
    required this. species,
    required this. age,
    required this. gender,
  });


  factory petDetailModel.fromJson(Map<String, dynamic> json) {
    return petDetailModel(
      id: json["id"],
      name: json["name"],
      species: json["species"],
      age: json["age"],
      gender: json["gender"],
    );
  }
}