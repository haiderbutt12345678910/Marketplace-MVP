import '../../../Domain/Entities/Product/prodcutattribute_entity.dart';

class ProductAttributeModel extends ProductAttributeEntity {
  ProductAttributeModel({
    super.productId,
    super.subCategoryId,
    super.attributeFormId,
  });

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      productId: json['product_id'],
      subCategoryId: json['sub_category_id'],
      attributeFormId: json['attribute_form_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'sub_category_id': subCategoryId,
      'attribute_form_id': attributeFormId,
    };
  }
}
