class CategoryModel {
  final String name;
  final String url;
  final String image_url;
  final String category;
  final String price;

  CategoryModel({
    required this.name,
    required this.url,
    required this.image_url,
    required this.category,
    required this.price,

  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"],
      url: json["url"],
      image_url: json["image_url"],
      category: json["category"],
      price: json["price"],
    );
  }
}