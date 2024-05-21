import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/apptextformfeild.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/AppCores/conststrings/AppStrings/authentication_strings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/termsandconditions.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _textEditingControllerPassowrdReset =
      TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingControllerPassowrdReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          leading: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Image.asset(AppAssetsUrl.brandLogo)),
        ),
        body: Form(key: key, child: _forgetPasswordWidget(context, size)));
  }

  Widget _forgetPasswordWidget(BuildContext context, Size size) {
    double availableHeight = ScreenSizeUtil.getAvaiableHeight(context,
        removeAppBarSize: true,
        removePaddingBottom: true,
        removePaddingTop: true);

    return SingleChildScrollView(
      child: SizedBox(
        height: availableHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: size.height * .1),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  HeadingsWidet(
                      h1: AuthenticationStrings.titleResetPassowrdText,
                      h2: AuthenticationStrings.subTitleResetPasswordText,
                      alignment: Alignment.center),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: size.height * .03, vertical: size.height * .02),
                child: TextFormFeildWidget(
                    textEditingController: _textEditingControllerPassowrdReset,
                    idForFeild: "e")),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  horizontal: size.height * .01, vertical: size.height * .02),
              child: ElevatedButtonWidget(
                  buttonSize: null,
                  function: () {},
                  buttonText: AuthenticationStrings.btnResetPassword),
            ),
            const TermsAndPrivacyWidget()
          ],
        ),
      ),
    );
  }

  validator() {
    key.currentState!.validate();
  }
}
