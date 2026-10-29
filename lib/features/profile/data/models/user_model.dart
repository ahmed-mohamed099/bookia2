class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? city;
  final String? address;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.city,
    this.address,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      city: json['city'],
      address: json['address'],
      image: json['image'],
    );
  }
}
