import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';

class NotificationBadgeWidget extends StatelessWidget {
  final VoidCallback function;
  final String notificationId;
  const NotificationBadgeWidget(
      {super.key, required this.function, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    return _notificationWidegt(context);
  }

  Widget _notificationWidegt(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.height * .008, vertical: size.height * .008),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: AppColors.notifcationColor),
      child: Text(
        "0",
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: AppColors.notificationText),
      ),
    );
  }
}
