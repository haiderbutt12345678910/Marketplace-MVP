import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var notVals = [
    [false, "Pormotions"],
    [false, "Masseges"],
    [false, "Bids"]
  ];

  var themeVal = [
    [false, "DarkTheme"],
    [false, "CustomThemes"],
  ];

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
      appBar: AppBar(
          actions: const [CartNotificationWidget()],
          title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          children: [_notifications(context, size), _themes(context, size)],
        ),
      ),
    );
  }

  Widget _notifications(BuildContext context, Size size) {
    return Column(
      children: [
        SizedBox(
          height: size.height * .05,
        ),
        HeadingsWidet(h1: "Noticfications", alignment: Alignment.center),
        for (int i = 0; i < notVals.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(notVals[i][1] as String),
                    Switch(
                      value: notVals[i][0] as bool,
                      onChanged: (val) {
                        setState(() {
                          notVals[i][0] = val;
                        });
                      },
                      activeColor: AppColors.links, // Color when switch is on
                      inactiveTrackColor: AppColors
                          .bgVariantDarkTheme, // Color when switch is off
                    ),
                  ],
                ),
              )
            ],
          )
      ],
    );
  }

  Widget _themes(BuildContext context, Size size) {
    return Column(
      children: [
        SizedBox(
          height: size.height * .05,
        ),
        HeadingsWidet(h1: "Themes", alignment: Alignment.center),
        for (int i = 0; i < themeVal.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(themeVal[i][1] as String),
                    Switch(
                      value: themeVal[i][0] as bool,
                      onChanged: (val) {
                        setState(() {
                          themeVal[i][0] = val;
                        });
                      },
                      activeColor: AppColors.links, // Color when switch is on
                      inactiveTrackColor: AppColors
                          .bgVariantDarkTheme, // Color when switch is off
                    ),
                  ],
                ),
              )
            ],
          )
      ],
    );
  }
}
