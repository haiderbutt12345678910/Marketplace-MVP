import '../../../Domain/Entities/Product/productimage_entity.dart';

class ProductImageModel extends ProductImageEntity {
  ProductImageModel({
    super.productId,
    super.sourceName,
    super.sourceUrl,
    super.sourceType,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      productId: json['product_id'],
      sourceName: json['source_name'],
      sourceUrl: json['source_url'],
      sourceType: json['source_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'source_name': sourceName,
      'source_url': sourceUrl,
      'source_type': sourceType,
    };
  }
}
