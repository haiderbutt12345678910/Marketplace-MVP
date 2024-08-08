import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/apptextformfeild.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/AppCores/conststrings/AppStrings/authentication_strings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/StateMangemnet/Bloc/login_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/accountcheck.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/divider.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/termsandconditions.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcities_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/landingscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../AppCores/BlocStates/blocstates.dart';
import '../../../../AppCores/CoreWidgets/appbartitle.dart';
import '../../../../AppCores/CoreWidgets/circularprogess.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();

  final TextEditingController _textEditingControllerPassword =
      TextEditingController();

  final key = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<GetcitiesBloc>(context).getCities();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTtile(),
        ),
        body: Form(
            key: key,
            child: BlocConsumer<LogInCubit, BlocStates>(builder: (ctx, state) {
              return Stack(
                children: [
                  _logInWidget(context, size),
                  if (state is Loading) const ProgressCircularIndicatorCustom()
                ],
              );
            }, listener: (ctx, state) {
              if (state is Sucessfull) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LandingScreen()),
                );
              } else if (state is Failure) {
                var snackBar = const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text("Failure"),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {}
            })));
  }

  Widget _logInWidget(BuildContext context, Size size) {
    double availableHeight = ScreenSizeUtil.getAvaiableHeight(context,
        removeAppBarSize: true,
        removePaddingBottom: true,
        removePaddingTop: true);
    return SingleChildScrollView(
      child: SizedBox(
        height: availableHeight,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .04,
            ),
            HeadingsWidet(
                h1: AuthenticationStrings.titlelogInText,
                alignment: Alignment.center),
            _signInWithEmailAndPassword(context, size),
            const DividerWidget(),
            _socailSignIns(size),
            const TermsAndPrivacyWidget()
          ],
        ),
      ),
    );
  }

  //For SignInWithEmailAndPassword
  Widget _signInWithEmailAndPassword(BuildContext context, Size size) {
    EdgeInsets textFormFeildSize = EdgeInsets.symmetric(
      horizontal: size.height * .01,
      vertical: size.height * .005,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          margin: textFormFeildSize,
          child: TextFormFeildWidget(
            idForFeild: "e",
            textEditingController: _textEditingControllerEmail,
          ),
        ),
        Container(
          width: double.infinity,
          margin: textFormFeildSize,
          child: TextFormFeildWidget(
            idForFeild: "p",
            textEditingController: _textEditingControllerPassword,
          ),
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.height * .02),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const ForgetPasswordScreen()),
                    // );
                  },
                  child: Text(AuthenticationStrings.btnForgotPassword)),
              AccountCheckWidegt(isLoginPage: true, size: size),
            ],
          ),
        ),
        ElevatedButtonWidget(
          bgColor: Colors.greenAccent,
          buttonSize: null,
          function: submit,
          buttonText: AuthenticationStrings.btnlogInText,
        ),
      ],
    );
  }

  Widget _socailSignIns(Size size) {
    return Column(
      children: [
        ElevatedButtonWidget.withIcon(
          buttonSize: null,
          function: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const LandingScreen()),
            // );
          },
          buttonText: "Google",
          iconData: Icons.report_gmailerrorred,
        ),
      ],
    );
  }

  void submit() {
    BlocProvider.of<LogInCubit>(context).logIn(
        _textEditingControllerEmail.text, _textEditingControllerPassword.text);
  }

  validator() {
    if (key.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    }
  }
}
