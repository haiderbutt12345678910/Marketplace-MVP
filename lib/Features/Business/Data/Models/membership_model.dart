import '../../Domain/Entities/membership_entity.dart';

class MembershipModel extends MembershipEntity {
  const MembershipModel({
    required super.id,
    required super.title,
    required super.allowProductsPerMonth,
    required super.saleCommission,
    required super.tax,
    required super.transactionCharges,
    required super.otherCharges,
    required super.imagesAllow,
    required super.allowProductVideo,
    required super.withdrawDuration,
    required super.publicationStatus,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id'],
      title: json['title'],
      allowProductsPerMonth: int.parse(json['allow_products_per_month']),
      saleCommission: int.parse(json['sale_commission']),
      tax: int.parse(json['tax']),
      transactionCharges: int.parse(json['transection_charges']),
      otherCharges: int.parse(json['other_charges']),
      imagesAllow: int.parse(json['images_allow']),
      allowProductVideo: json['allow_product_video'] == 'yes',
      withdrawDuration: int.parse(json['withdraw_duration']),
      publicationStatus: json['publication_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'allow_products_per_month': allowProductsPerMonth.toString(),
      'sale_commission': saleCommission.toString(),
      'tax': tax.toString(),
      'transection_charges': transactionCharges.toString(),
      'other_charges': otherCharges.toString(),
      'images_allow': imagesAllow.toString(),
      'allow_product_video': allowProductVideo ? 'yes' : 'no',
      'withdraw_duration': withdrawDuration.toString(),
      'publication_status': publicationStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
