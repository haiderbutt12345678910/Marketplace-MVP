import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String mobileNo;
  final String cityName;
  final String shippingAddress;
  final String personalAddress;
  final String profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.cityName,
    required this.shippingAddress,
    required this.personalAddress,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
