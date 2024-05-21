import '../../../Domain/Entities/Product/productpormotion_entity.dart';

class ProductPromotionModel extends ProductPromotionEntity {
  ProductPromotionModel({
    super.promotionTitle,
    super.promotionPrice,
    super.description,
  });

  factory ProductPromotionModel.fromJson(Map<String, dynamic> json) {
    return ProductPromotionModel(
      promotionTitle: json['promotion_title'],
      promotionPrice: json['promotion_price']?.toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'promotion_title': promotionTitle,
      'promotion_price': promotionPrice,
      'description': description,
    };
  }
}
