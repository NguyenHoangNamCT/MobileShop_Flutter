import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String categoryId;
  final String description;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    required this.description,
    required this.createdAt,
  });

  // Phương thức để chuyển dữ liệu từ Firestore thành đối tượng Product
  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Phương thức để chuyển đổi Product thành Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'categoryId': categoryId,
      'description': description,
      'createdAt': createdAt,
    };
  }
}