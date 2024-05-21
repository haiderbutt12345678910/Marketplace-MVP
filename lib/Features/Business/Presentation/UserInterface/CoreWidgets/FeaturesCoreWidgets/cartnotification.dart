import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/notification_widget.dart';

import '../../Screens/cart_screen.dart';

class CartNotificationWidget extends StatelessWidget {
  const CartNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = ScreenSizeUtil.getScreenSized(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, right: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.height * .015, vertical: size.height * .015),
              decoration: BoxDecoration(
                  color: AppColors.bgDarkTheme, shape: BoxShape.circle),
              child: const Icon(
                CupertinoIcons.cart,
                size: 15,
              ),
            ),
            Positioned(
              right: 0,
              top: 4,
              child: NotificationBadgeWidget(
                notificationId: "cart",
                function: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
