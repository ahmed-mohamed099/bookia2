class CartItemModel {
  final int id;
  final int productId;
  final String name;
  final String image;
  final num price;
  final int quantity;
  final int stock;
  final num total;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.total,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['item_id'],
      productId: json['item_product_id'],
      name: json['item_product_name'] ?? '',
      image: json['item_product_image'] ?? '',
      price: num.tryParse('${json['item_product_price_after_discount']}') ?? 0,
      quantity: json['item_quantity'] ?? 1,
      stock: json['item_product_stock'] ?? 0,
      total: num.tryParse('${json['item_total']}') ?? 0,
    );
  }
}

class CartModel {
  final num total;
  final List<CartItemModel> items;

  CartModel({required this.total, required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final List list = json['cart_items'] ?? [];
    return CartModel(
      // The server sends total as text sometimes ("294.84") and as a number other times.
      total: num.tryParse('${json['total']}') ?? 0,
      items: list.map((e) => CartItemModel.fromJson(e)).toList(),
    );
  }
}
