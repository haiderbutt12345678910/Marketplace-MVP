import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/Category/subcategory_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  SubCategoryModel({
    super.categoryId,
    super.categoryName,
    super.categoryImage,
    super.status,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'category_id': categoryId,
      'category_name': categoryName,
      'category_image': categoryImage,
      'status': status,
    };
    return data;
  }
}
