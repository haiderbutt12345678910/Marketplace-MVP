import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/User/user_entity.dart';

class UsersModel extends UsersEntity {
  UsersModel({
    super.deviceToken,
    super.email,
    super.name,
    super.subscriptionId,
    super.sellerSlug,
    super.googleId,
    super.mobileNo,
    super.password,
    super.role,
    super.status,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      deviceToken: json['device_token'],
      email: json['email'],
      name: json['name'],
      subscriptionId: json['subscription_id'],
      sellerSlug: json['seller_slug'],
      googleId: json['google_id'],
      mobileNo: json['mobile_no'],
      password: json['password'],
      role: json['role'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'device_token': deviceToken,
      'email': email,
      'name': name,
      'subscription_id': subscriptionId,
      'seller_slug': sellerSlug,
      'google_id': googleId,
      'mobile_no': mobileNo,
      'password': password,
      'role': role,
      'status': status,
    };
    return data;
  }
}
