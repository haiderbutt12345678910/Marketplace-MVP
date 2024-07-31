import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appbartitle.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemDetailsEntity/itemdetail_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/sellerstore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class StoreSetupForm extends StatefulWidget {
  const StoreSetupForm({super.key});

  @override
  State<StoreSetupForm> createState() => _StoreSetupFormState();
}

class _StoreSetupFormState extends State<StoreSetupForm> {
  final TextEditingController _storeNametextEditingController =
      TextEditingController();
  final MultiSelectController _categoriestextEditingController =
      MultiSelectController();

  final MultiSelectController _colortxtEditingController =
      MultiSelectController();
  final MultiSelectController _sizetxtEditingController =
      MultiSelectController();
  final MultiSelectController _condtiontxtEditingController =
      MultiSelectController();

  final TextEditingController _descriptiontextEditingController =
      TextEditingController();

  final TextEditingController _pricetextEditingController =
      TextEditingController();
  final TextEditingController _discounttextEditingController =
      TextEditingController();

  final TextEditingController _shippingCostEditingController =
      TextEditingController();
  final PageController _pageController = PageController();
  File? image;
  File? coverPhoto;

  @override
  void dispose() {
    _colortxtEditingController.dispose();
    _sizetxtEditingController.dispose();
    _condtiontxtEditingController.dispose();
    _categoriestextEditingController.dispose();
    _pricetextEditingController.dispose();
    _discounttextEditingController.dispose();
    _shippingCostEditingController.dispose();
    _pageController.dispose();
    _descriptiontextEditingController.dispose();
    _storeNametextEditingController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Create a GlobalKey

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: const AppBarTtile(),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset(AppAssetsUrl.brandLogo),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: PageView(
            controller: _pageController,
            children: [
              _storeName(context, size),
              _cities(context, size),
              _logo(context, size),
              _coverPhoto(context, size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _storeName(BuildContext context, Size size) {
    return SizedBox(
      height: size.height,
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
                    h1: "Enrter Store Name",
                    h2: "The store name  should reflects your selling point",
                    alignment: Alignment.center),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: size.height * .03,
              ),
              child: _textFeild(
                _storeNametextEditingController,
                "Enter Store Name",
                100,
                TextInputType.emailAddress,
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: size.height * .01),
            child: ElevatedButtonWidget(
                bgColor: Colors.orangeAccent,
                buttonSize: null,
                function: () {
                  if (_storeNametextEditingController.text.isNotEmpty) {
                    _toNextPage();
                  } else {
                    showMySnackBar(context, "Store Name can not be empty");
                  }
                },
                buttonText: "Proceed"),
          ),
        ],
      ),
    );
  }

  Widget _textFeild(TextEditingController textEditingController, String hint,
      int maxLenght, TextInputType textInputType) {
    return TextField(
      cursorHeight: 30,
      cursorColor: AppColors.cursorColor,
      textAlign: TextAlign.left,
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        counterText: maxLenght.toString(),
        hintText: hint,
      ),
      maxLength: maxLenght,
    );
  }

  void showMySnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.red),
        ),
        action: SnackBarAction(
          label: 'Error',
          onPressed: () {
            // Perform undo action (optional)
          },
        ),
        duration: const Duration(
            seconds:
                3), // Duration for which the SnackBar is visible (optional)
      ),
    );
  }

  void _toNextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Widget _logo(BuildContext context, Size size) {
    return SizedBox(
      height: size.height,
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
                    h1: "Provide Logo For Store ",
                    h2: "images should be 128x128 with max resolutions",
                    alignment: Alignment.center),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              getFromGallery();
            },
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50.0,
                backgroundImage: image != null
                    ? FileImage(File(image!.path))
                    : const NetworkImage(
                            "https://tse1.mm.bing.net/th?id=OIP.tfaSK3pwhLrecMjEcbcA9gHaHa&pid=Api&P=0&h=220")
                        as ImageProvider),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: size.height * .01),
            child: ElevatedButtonWidget(
                bgColor: Colors.orangeAccent,
                buttonSize: null,
                function: () {
                  if (image != null) {
                    _toNextPage();
                  } else {
                    showMySnackBar(context, "Please provide Logo");
                  }
                },
                buttonText: "Proceed"),
          ),
        ],
      ),
    );
  }

  Widget _coverPhoto(BuildContext context, Size size) {
    return SizedBox(
      height: size.height,
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
                    h1: "Provide Cover Photo For Store ",
                    h2: "images should be 512x512 with max resolutions",
                    alignment: Alignment.center),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              getFromGalleryCover();
            },
            child: Container(
              width: double.infinity,
              height: size.height * .2,
              margin: EdgeInsets.symmetric(horizontal: size.width * .05),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: coverPhoto != null
                          ? FileImage(File(coverPhoto!.path))
                          : const NetworkImage(
                                  "https://tse1.mm.bing.net/th?id=OIP.tfaSK3pwhLrecMjEcbcA9gHaHa&pid=Api&P=0&h=220")
                              as ImageProvider,
                      fit: BoxFit.contain)),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: size.height * .01),
            child: ElevatedButtonWidget(
                bgColor: Colors.orangeAccent,
                buttonSize: null,
                function: () {
                  if (coverPhoto != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerstoreScreen(
                                isMine: true,
                                images: [image as File, coverPhoto as File],
                                storeName: _storeNametextEditingController.text,
                                itemDetailEntity: const ItemDetailEntity(),
                              )),
                    );
                  } else {
                    showMySnackBar(context, "Please provide Logo");
                  }
                },
                buttonText: "Go Live"),
          ),
        ],
      ),
    );
  }

  Widget _cities(BuildContext context, Size size) {
    return SizedBox(
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: size.width * .05),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .1,
                ),
                HeadingsWidet(
                    h1: "Choose Cities You Are Selling ",
                    h2: "You Can Choose From Multiple Categories Of the products to choose from the list",
                    alignment: Alignment.center),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .2),
            child: MultiSelectDropDown(
              suffixIcon: Icon(
                Icons.arrow_downward,
                color: AppColors.bgDarkTheme,
              ),
              optionsBackgroundColor: AppColors.bgVariantDarkTheme,
              singleSelectItemStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
              hint: 'Select Cities',
              fieldBackgroundColor: AppColors.bgDarkTheme,
              controller: _categoriestextEditingController,
              onOptionSelected: (List<ValueItem> selectedOptions) {},
              options: const <ValueItem>[
                ValueItem(label: 'Islamabad', value: 'Islamabad'),
                ValueItem(label: 'Karachi', value: 'Karachi'),
                ValueItem(label: 'Lahore', value: 'Lahore'),
                ValueItem(label: 'Peshawar', value: 'Peshawar'),
                ValueItem(label: 'Multan', value: 'Multan'),
                ValueItem(label: 'Others', value: 'Others'),
              ],
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 300,
              optionTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              selectedOptionIcon: Icon(
                Icons.check_circle,
                color: AppColors.iconsDarkTheme,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: size.height * .01),
            child: ElevatedButtonWidget(
                bgColor: Colors.orangeAccent,
                buttonSize: null,
                function: () {
                  if (_categoriestextEditingController
                      .selectedOptions.isNotEmpty) {
                    _toNextPage();
                  } else {
                    showMySnackBar(context, "Please provide Cities");
                  }
                },
                buttonText: "Proceed"),
          ),
        ],
      ),
    );
  }

  getFromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 10,
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  getFromGalleryCover() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 10,
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (pickedFile != null) {
        setState(() {
          coverPhoto = File(pickedFile.path);
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
