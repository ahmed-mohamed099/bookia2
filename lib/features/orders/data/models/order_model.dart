class OrderModel {
  final int id;
  final String code;
  final String date;
  final String status;
  final String total;

  OrderModel({
    required this.id,
    required this.code,
    required this.date,
    required this.status,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      code: json['order_code']?.toString() ?? '',
      date: json['order_date']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      total: json['total']?.toString() ?? '0',
    );
  }
}
