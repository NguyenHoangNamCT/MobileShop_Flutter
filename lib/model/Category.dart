import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  // Phương thức để chuyển dữ liệu từ Firestore thành đối tượng Category
  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
      icon: data['icon'] ?? '',
    );
  }

  // Phương thức để chuyển đổi Category thành Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }

  // Hàm chuyển đổi chuỗi icon thành IconData
  IconData getIcon() {
    switch (icon) {
      case 'phone_android':
        return Icons.phone_android;
      case 'tablet':
        return Icons.tablet;
      case 'laptop':
        return Icons.laptop;
      case 'headphones':
        return Icons.headphones;
      case 'tv':
        return Icons.tv;
      default:
        return Icons.category; // Default icon nếu không tìm thấy
    }
  }
}