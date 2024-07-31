import 'package:equatable/equatable.dart';

class MembershipEntity extends Equatable {
  final int id;
  final String title;
  final int allowProductsPerMonth;
  final int saleCommission;
  final int tax;
  final int transactionCharges;
  final int otherCharges;
  final int imagesAllow;
  final bool allowProductVideo;
  final int withdrawDuration;
  final String publicationStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const MembershipEntity({
    required this.id,
    required this.title,
    required this.allowProductsPerMonth,
    required this.saleCommission,
    required this.tax,
    required this.transactionCharges,
    required this.otherCharges,
    required this.imagesAllow,
    required this.allowProductVideo,
    required this.withdrawDuration,
    required this.publicationStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
