import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/Category/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.categoryName,
    super.categoryImage,
    super.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'category_name': categoryName,
      'category_image': categoryImage,
      'status': status,
    };
    return data;
  }
}
