import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/Themes/appbar_themes.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/Themes/bottomnavbar_themes.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/Themes/inputdecoration_themes.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/Themes/text_themes.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/Themes/textbutton_themes.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/loginscreen.dart';

import 'Features/Business/Presentation/UserInterface/Screens/cart_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = ScreenSizeUtil.getScreenSized(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            fontFamily: AppFontsUrl.primaryFonts,
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme:
                AppBottomNavBarThemes.darkBg(context, false),
            textTheme: AppTextThemesData.textTheme(context, screenSize, true),
            inputDecorationTheme:
                InputDecorationsThemesData.inputDecorationTheme(
                    context, screenSize, true),
            textButtonTheme:
                AppTextButtonThemeData.textButtonThemedata(context, screenSize),
            appBarTheme:
                AppappBarThemes.appappBarThemes(context, screenSize, true),
            tabBarTheme: TabBarTheme(
                overlayColor:
                    WidgetStateProperty.all<Color>(AppColors.bgDarkTheme),
                labelColor:
                    AppColors.textDarkTheme, // Color of the selected tab label
                unselectedLabelColor: AppColors
                    .textVaraiantDarkTheme, // Color of the unselected tab labels
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: AppColors.textDarkTheme,
                      width: 2.0), // Customize the indicator
                  insets: const EdgeInsets.symmetric(horizontal: 4),
                ))),
        title: 'Flutter Demo',
        home: const LogInScreen());
  }
}
