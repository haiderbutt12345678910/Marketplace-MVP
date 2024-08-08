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
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/StateMangemnet/Bloc/login_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/loginscreen.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/registerscreen.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/cart_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcategories_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcities_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getitems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getrecentlyviewed_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsaveditems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsingleitem_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsubcategories_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getuser_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/updateuser_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/storesetupform.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/landingscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dependencyInjection.dart ' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final String? token = sharedPreferences.getString('token');
  await di.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp(
    tokken: token,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final String? tokken;
  const MyApp({super.key, this.tokken});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = ScreenSizeUtil.getScreenSized(context);

    return MultiBlocProvider(
      providers: [
        //Auth
        BlocProvider<LogInCubit>(create: (_) => di.sl<LogInCubit>()),

        //BusinessFeatures
        BlocProvider<GetCategoriesBloc>(
            create: (_) => di.sl<GetCategoriesBloc>()),

        BlocProvider<GetSubCategoriesBloc>(
            create: (_) => di.sl<GetSubCategoriesBloc>()),

        BlocProvider<GetitemsBloc>(create: (_) => di.sl<GetitemsBloc>()),

        BlocProvider<GetUserBloc>(create: (_) => di.sl<GetUserBloc>()),

        BlocProvider<UpdateuserBloc>(create: (_) => di.sl<UpdateuserBloc>()),
        BlocProvider<GetcitiesBloc>(create: (_) => di.sl<GetcitiesBloc>()),

        BlocProvider<GetRecentlyViewditemsBloc>(
            create: (_) => di.sl<GetRecentlyViewditemsBloc>()),
        BlocProvider<GetsaveditemsBloc>(
            create: (_) => di.sl<GetsaveditemsBloc>()),

        BlocProvider<GetCartBloc>(create: (_) => di.sl<GetCartBloc>()),

        BlocProvider<GetsingleitemBloc>(
            create: (_) => di.sl<GetsingleitemBloc>()),
      ],
      child: MaterialApp(
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
              textButtonTheme: AppTextButtonThemeData.textButtonThemedata(
                  context, screenSize),
              appBarTheme:
                  AppappBarThemes.appappBarThemes(context, screenSize, true),
              tabBarTheme: TabBarTheme(
                  overlayColor:
                      WidgetStateProperty.all<Color>(AppColors.bgDarkTheme),
                  labelColor: AppColors
                      .textDarkTheme, // Color of the selected tab label
                  unselectedLabelColor: AppColors
                      .textVaraiantDarkTheme, // Color of the unselected tab labels
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        color: AppColors.textDarkTheme,
                        width: 2.0), // Customize the indicator
                    insets: const EdgeInsets.symmetric(horizontal: 4),
                  ))),
          title: 'Flutter Demo',
          home: tokken == null ? const LogInScreen() : const StoreSetupForm()),
    );
  }
}
