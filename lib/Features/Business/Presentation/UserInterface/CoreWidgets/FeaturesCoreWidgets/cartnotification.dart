import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/cart_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/notification_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Screens/cart_screen.dart';

class CartNotificationWidget extends StatefulWidget {
  const CartNotificationWidget({super.key});

  @override
  State<CartNotificationWidget> createState() => _CartNotificationWidgetState();
}

class _CartNotificationWidgetState extends State<CartNotificationWidget> {
  @override
  void initState() {
    var list = BlocProvider.of<GetCartBloc>(context).getLocalList();
    if (list.isEmpty) {
      BlocProvider.of<GetCartBloc>(context).getCat();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = ScreenSizeUtil.getScreenSized(context);
    return BlocBuilder<GetCartBloc, BlocStates>(builder: (ctx, state) {
      var list = BlocProvider.of<GetCartBloc>(context).getLocalList();
      String count = list.length.toString();

      if (state is Loading) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: 30,
          width: 30,
          child: const ProgressCircularIndicatorCustom(
            bgColor: Colors.green,
          ),
        );
      }
      if (state is Sucessfull) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 5, right: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * .015,
                      vertical: size.height * .015),
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
                    count: count,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return CircularProgressIndicator(
          color: AppColors.cursorColor,
        );
      }
    });
  }
}
