class ProductModel {
  final int id;
  final String name;
  final String image;
  final String price;
  final num priceAfterDiscount;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.priceAfterDiscount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      priceAfterDiscount: json['price_after_discount'],
    );
  }
}