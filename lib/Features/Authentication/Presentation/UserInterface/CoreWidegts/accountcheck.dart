import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AppStrings/authentication_strings.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/loginscreen.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Presentation/UserInterface/registerscreen.dart';

class AccountCheckWidegt extends StatelessWidget {
  final bool isLoginPage;
  final Size size;
  const AccountCheckWidegt(
      {super.key, required this.isLoginPage, required this.size});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          isLoginPage
              ? AuthenticationStrings.subTitleDontHaveAnAccountText
              : AuthenticationStrings.subTitleAlreadyHaveAnAccountText,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: size.height * .02),
        ),
        TextButton(
            onPressed: () {
              if (isLoginPage) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()),
                );
              }
            },
            child: Text(isLoginPage
                ? AuthenticationStrings.btnregisterText
                : AuthenticationStrings.btnlogInText))
      ],
    );
  }
}
