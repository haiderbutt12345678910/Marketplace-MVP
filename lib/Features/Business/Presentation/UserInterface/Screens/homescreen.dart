import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getitems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/topbannerads.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/products_overview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetitemsBloc>(context).getItems(1);
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              child: Column(
                children: [
                  Column(
                    children: [
                      BannerAdsWidget(
                        height: size.height * .2,
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      _productSection(context, size)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productSection(BuildContext context, Size size) {
    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      var list = BlocProvider.of<GetitemsBloc>(context).getLocalList();
      if (state is Loading) {
        return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: size.height * .585,
            child: const ProgressCircularIndicatorCustom(
              bgColor: Colors.white,
            ));
      } else if (state is Sucessfull) {
        return SizedBox(
          height: size.height * .585,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * .03),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.height * .02,
                  ),
                  child: HeadingsWidet(
                      h1: 'Recommended Items', alignment: Alignment.bottomLeft),
                ),
                SizedBox(height: size.height * .01),
                _recomendedItems(context, size, state, list),
                SizedBox(height: size.height * .03),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.height * .02,
                  ),
                  child: HeadingsWidet(
                      h1: 'Random Items', alignment: Alignment.bottomLeft),
                ),
                SizedBox(height: size.height * .01),
                _randomItems(context, size, state, list),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * .1),
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                      buttonSize: null,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductsOverview()),
                        );
                      },
                      buttonText: "View All"),
                )
              ],
            ),
          ),
        );
      } else {
        return Expanded(
          child: InkWell(
            onTap: () {
              BlocProvider.of<GetitemsBloc>(context).getItems(1);
            },
            child: HeadingsWidet.withH1Icon(
              iconData: (Icons.refresh),
              h1: "Something Went Wrong",
              alignment: Alignment.center,
              h2: "Tap to retry",
            ),
          ),
        );
      }
    });
  }

  Widget _recomendedItems(
      BuildContext context, Size size, BlocStates state, var list) {
    return Column(
      children: [
        for (int i = 0; i < list.length / 6; i++)
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: ProductOverViewWidget(
                        size: size, blocStates: state, itemEntity: list[i])),
                SizedBox(
                  width: size.width * .01,
                ),
                Expanded(
                    child: ProductOverViewWidget(
                        size: size,
                        blocStates: state,
                        itemEntity: list[i + 1])),
                SizedBox(
                  width: size.width * .01,
                ),
              ],
            ),
          )
      ],
    );
  }

  Widget _randomItems(
      BuildContext context, Size size, BlocStates state, var list) {
    return Column(
      children: [
        for (int i = 0; i < list.length / 6; i++)
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: ProductOverViewWidget(
                        size: size, blocStates: state, itemEntity: list[i])),
                SizedBox(
                  width: size.width * .01,
                ),
                Expanded(
                    child: ProductOverViewWidget(
                        size: size,
                        blocStates: state,
                        itemEntity: list[i + 1])),
                SizedBox(
                  width: size.width * .01,
                ),
              ],
            ),
          )
      ],
    );
  }
}
