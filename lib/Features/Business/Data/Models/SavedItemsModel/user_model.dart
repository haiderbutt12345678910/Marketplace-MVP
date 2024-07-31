import '../../../Domain/Entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.mobileNo,
    required super.cityName,
    required super.shippingAddress,
    required super.personalAddress,
    required super.profileImage,
    required super.createdAt,
    required super.updatedAt,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      cityName: json['city_name'],
      shippingAddress: json['shipping_address'],
      personalAddress: json['personal_address'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile_no': mobileNo,
      'city_name': cityName,
      'shipping_address': shippingAddress,
      'personal_address': personalAddress,
      'profile_image': profileImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
