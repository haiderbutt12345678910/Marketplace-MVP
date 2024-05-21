import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AppStrings/authentication_strings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AppStrings/global_strings.dart';

class TextFormFeildWidget extends StatefulWidget {
  final String idForFeild;

  final TextEditingController textEditingController;
  const TextFormFeildWidget({
    super.key,
    required this.textEditingController,
    required this.idForFeild,
  });

  @override
  State<TextFormFeildWidget> createState() => _TextFormFeildWidgetState();
}

class _TextFormFeildWidgetState extends State<TextFormFeildWidget> {
  late final String _hint;
  late final String _label;
  late final IconData _iconData;
  late final TextInputType _textInputType;
  late String? Function(String?) _validator;

  bool _isObscure = false;

  @override
  void initState() {
    _valuesSetUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              _label,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        SizedBox(
          height: size.height * .009,
        ),
        TextFormField(
          onSaved: (_) {},
          onEditingComplete: () {},
          onFieldSubmitted: (_) {},
          cursorColor: AppColors.cursorColor,
          obscureText: _isObscure,
          validator: _validator,
          controller: widget.textEditingController,
          keyboardType: _textInputType,
          decoration: InputDecoration(
            suffixIcon: widget.idForFeild == "p"
                ? IconButton(
                    onPressed: () {
                      _changePasswordVisbility();
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ))
                : null,
            prefixIcon: Icon(
              _iconData,
            ),
            hintText: _hint,
          ),
        ),
      ],
    );
  }

  void _valuesSetUp() {
    //for email setup
    if (widget.idForFeild == "e") {
      _hint = AuthenticationStrings.hinttextFormFeildEmail;
      _label = AuthenticationStrings.labeltextFormFeildEnterEmail;
      _iconData = Icons.email;
      _textInputType = TextInputType.emailAddress;
      _validator = _emailValidation;
    }
    //for password setup
    else if (widget.idForFeild == "p") {
      _hint = AuthenticationStrings.hinttextFormFeildentpassword;
      _label = AuthenticationStrings.labeltextFormFeildentEnterpassword;
      _iconData = Icons.lock;
      _textInputType = TextInputType.visiblePassword;
      _validator = _passwordValidation;
    }

    //for other feild setups
    else {
      _validator = _emptyFeildValidation;
    }
  }

  String? _emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return GlobalStrings.errorTextFormFeildEmpty;
    }

    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    if (!emailRegex.hasMatch(value)) {
      return AuthenticationStrings.errorTextFormFeildInvalidFormatEmail;
    }
    return null;
  }

  String? _passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return GlobalStrings.errorTextFormFeildEmpty;
    }

    if (value.length < 8) {
      return AuthenticationStrings.errorTextFormFeildFormatInvalidPassword[0];
    }
    // Check if password contains at least one letter, one number, and one special character
    final RegExp letterRegex = RegExp(r'[a-zA-Z]');
    final RegExp numberRegex = RegExp(r'[0-9]');
    final RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!letterRegex.hasMatch(value) ||
        !numberRegex.hasMatch(value) ||
        !specialCharRegex.hasMatch(value)) {
      return AuthenticationStrings.errorTextFormFeildFormatInvalidPassword[1];
    }
    return null;
  }

  String? _emptyFeildValidation(String? value) {
    if (value == null || value.isEmpty) {
      return GlobalStrings.errorTextFormFeildEmpty;
    }

    return null;
  }

  void _changePasswordVisbility() {
    _isObscure = !_isObscure;

    setState(() {});
  }
}
