import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/apptextformfeild.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/AppCores/conststrings/AppStrings/authentication_strings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/accountcheck.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/divider.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/termsandconditions.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/landingscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();

  final TextEditingController _textEditingControllerPassword =
      TextEditingController();
  final key = GlobalKey<FormState>();

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
          leading: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Image.asset(AppAssetsUrl.brandLogo)),
          title: Text(
            AuthenticationStrings.btnregisterText,
          ),
        ),
        body: Form(key: key, child: _logInWidget(context, size)));
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
                h1: AuthenticationStrings.titleregisterText,
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
                  onPressed: () {},
                  child: Text(AuthenticationStrings.btnForgotPassword)),
              AccountCheckWidegt(isLoginPage: false, size: size),
            ],
          ),
        ),
        ElevatedButtonWidget(
          buttonSize: null,
          function: () {},
          buttonText: AuthenticationStrings.btnregisterText,
        ),
      ],
    );
  }

  Widget _socailSignIns(Size size) {
    return Column(
      children: [
        ElevatedButtonWidget.withIcon(
          buttonSize: null,
          function: () {},
          buttonText: "Google",
          iconData: Icons.report_gmailerrorred,
        ),
      ],
    );
  }

  validator() {
    if (key.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    }
  }
}
