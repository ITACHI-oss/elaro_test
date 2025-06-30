class ProductModel {
  final int id;
  final String name;
  final String image;
  final int categoryId;
  final String color;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId,
    required this.color,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name_uz'] ?? '',
      image: json['image'] ?? '',
      categoryId: json['category_id'] ?? 0,
      color: json['color'] ?? '',
    );
  }
}
