import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/apptextformfeild.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/AppCores/conststrings/AppStrings/authentication_strings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/accountcheck.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/divider.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/CoreWidegts/termsandconditions.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/cart_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcities_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/landingscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../AppCores/CoreWidgets/appbartitle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerName =
      TextEditingController();
  final TextEditingController _textEditingControllerPhone =
      TextEditingController();

  final TextEditingController _textEditingControllerPassword =
      TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
    _textEditingControllerName.dispose();
    _textEditingControllerPhone.dispose();

    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<GetcitiesBloc>(context).getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const AppBarTtile()),
        body: BlocBuilder<GetcitiesBloc, BlocStates>(
          builder: (ctx, state) {
            if (state is Loading) {
              return const ProgressCircularIndicatorCustom();
            } else if (state is Sucessfull) {
              return Form(key: key, child: _logInWidget(context, size));
            } else {
              return InkWell(
                onTap: () {
                  BlocProvider.of<GetcitiesBloc>(context).getCities();
                },
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeadingsWidet(
                        h1: "Error Occured",
                        alignment: Alignment.center,
                        h2: "Failed To Load Data Tap To Retry!",
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
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
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: textFormFeildSize,
                child: TextFormFeildWidget(
                  idForFeild: "name",
                  textEditingController: _textEditingControllerName,
                ),
              ),
            ),
            SizedBox(
              width: size.width * .01,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: textFormFeildSize,
                child: TextFormFeildWidget(
                  idForFeild: "phone",
                  textEditingController: _textEditingControllerPhone,
                ),
              ),
            ),
          ],
        ),
        _selcetCities(context, size),
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
        ElevatedButtonWidget(
          buttonSize: null,
          function: () {},
          buttonText: AuthenticationStrings.btnregisterText,
        ),
      ],
    );
  }

  Widget _selcetCities(BuildContext context, Size size) {
    var citiesList = BlocProvider.of<GetcitiesBloc>(context).getCitiesLocal();
    List<String> list = [];
    for (int i = 0; i < citiesList.length; i++) {
      list.add(citiesList[i].cityName);
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.height * .01,
        vertical: size.height * .04,
      ),
      child: CustomDropdown<String>(
        hintText: 'Select Cities',
        items: list,
        decoration: CustomDropdownDecoration(
          closedBorder: const Border(
              top: BorderSide(color: Colors.black, width: 1.0),
              left: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0)),
          expandedBorder: const Border(
              top: BorderSide(color: Colors.black, width: 1.0),
              left: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0)),
          closedBorderRadius: BorderRadius.zero,
          expandedBorderRadius: BorderRadius.zero,
          hintStyle: Theme.of(context).textTheme.titleLarge,
        ),
        onChanged: (value) {
          // Handle dropdown value change
        },
      ),
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
