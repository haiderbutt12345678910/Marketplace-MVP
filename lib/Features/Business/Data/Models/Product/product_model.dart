import '../../../Domain/Entities/Product/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.userId,
    super.productTitle,
    super.categoryId,
    super.subCategoryId,
    super.brandId,
    super.productCondition,
    super.saleType,
    super.auctionDuration,
    super.startBidPrice,
    super.productSalePrice,
    super.allowOffer,
    super.quantity,
    super.discountPrice,
    super.shippingId,
    super.promotion,
    super.promotionId,
    super.description,
    super.publicationStatus,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      userId: json['user_id'],
      productTitle: json['product_title'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      brandId: json['brand_id'],
      productCondition: json['product_condition'],
      saleType: json['sale_type'],
      auctionDuration: json['auction_duration'],
      startBidPrice: json['start_bid_price']?.toDouble(),
      productSalePrice: json['product_sale_price']?.toDouble(),
      allowOffer: json['allow_offer'],
      quantity: json['quantity'],
      discountPrice: json['discount_price']?.toDouble(),
      shippingId: json['shipping_id'],
      promotion: json['promotion'],
      promotionId: json['promotion_id'],
      description: json['description'],
      publicationStatus: json['publication_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_title': productTitle,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'brand_id': brandId,
      'product_condition': productCondition,
      'sale_type': saleType,
      'auction_duration': auctionDuration,
      'start_bid_price': startBidPrice,
      'product_sale_price': productSalePrice,
      'allow_offer': allowOffer,
      'quantity': quantity,
      'discount_price': discountPrice,
      'shipping_id': shippingId,
      'promotion': promotion,
      'promotion_id': promotionId,
      'description': description,
      'publication_status': publicationStatus,
    };
  }
}
