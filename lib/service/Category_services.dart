import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/Category.dart';  // Đảm bảo bạn có model Category trong thư mục models

class CategoryService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lấy tất cả các danh mục từ Firestore
  static Future<List<Category>> getCategories() async {
    try {
      // Lấy danh sách documents từ Firestore collection 'categories'
      QuerySnapshot snapshot = await _firestore.collection('categories').get();

      // Chuyển đổi danh sách documents thành danh sách Category
      return snapshot.docs.map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }


}
