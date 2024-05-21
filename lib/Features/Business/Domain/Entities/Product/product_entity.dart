class ProductEntity {
  String? userId;
  String? productTitle;
  String? categoryId;
  String? subCategoryId;
  String? brandId;
  String? productCondition;
  String? saleType;
  String? auctionDuration;
  double? startBidPrice;
  double? productSalePrice;
  bool? allowOffer;
  int? quantity;
  double? discountPrice;
  String? shippingId;
  String? promotion;
  String? promotionId;
  String? description;
  String? publicationStatus;

  ProductEntity({
    this.userId,
    this.productTitle,
    this.categoryId,
    this.subCategoryId,
    this.brandId,
    this.productCondition,
    this.saleType,
    this.auctionDuration,
    this.startBidPrice,
    this.productSalePrice,
    this.allowOffer,
    this.quantity,
    this.discountPrice,
    this.shippingId,
    this.promotion,
    this.promotionId,
    this.description,
    this.publicationStatus,
  });
}
