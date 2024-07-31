import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/cart_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/checkout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../StateMangement/Blocs/getitems_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ItemEntity> list = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCartBloc>(context).getCat();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "eBay shoppimg cart",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          elevation: 0,
          actions: const [],
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(AppAssetsUrl.brandLogo),
          ),
        ),
        body: SingleChildScrollView(child: _cart(context, size)));
  }

  Widget _cart(BuildContext context, Size size) {
    // final avalaibleHeight = ScreenSizeUtil.getAvaiableHeight(context,
    //     removeAppBarSize: true,
    //     removePaddingBottom: true,
    //     removePaddingTop: true);+

    return BlocBuilder<GetCartBloc, BlocStates>(builder: (ctx, state) {
      var cartList = BlocProvider.of<GetCartBloc>(context).getLocalList();

      list = BlocProvider.of<GetitemsBloc>(context).getCartList(cartList);

      if (state is Loading) {
        return const ProgressCircularIndicatorCustom();
      } else if (state is Sucessfull) {
        return Column(
          children: [
            HeadingsWidet(h1: "Your Cart", alignment: Alignment.centerLeft),
            Column(
              children: [
                for (int i = 0; i < list.length; i++)
                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.height * .01),
                        width: double.infinity,
                        child: const Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      HeadingsWidet(
                          h1: "Seller Name", alignment: Alignment.topLeft),
                      _produtsOverView(context, size, i),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.height * .01),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    cartList[i].quantity.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ))),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.height * .01),
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {
                                        BlocProvider.of<GetCartBloc>(context)
                                            .removeCart(list[i].id as String);
                                      },
                                      child: const Text("Remove")))),
                        ],
                      )
                    ],
                  )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.height * .01),
              width: double.infinity,
              child: const Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            _total(context, size),
            HeadingsWidet(
                h1: "Frequently bought  together",
                alignment: Alignment.topLeft),
            __section4(context, size)
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }

  _produtsOverView(BuildContext context, Size size, int i) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: size.height * .15,
              child: SizedBox(
                height: size.height * .11,
                child: Image.network(
                  AppAssetsUrl.fallbackImageUrl,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.height * .02,
          ),
          Expanded(
              child: Column(
            children: [
              // Title
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                alignment: Alignment.topLeft,
                child: Text(
                  list[i].itemTitle as String,
                  maxLines: 2, // Allow wrapping for long titles
                  overflow: TextOverflow.ellipsis, // Truncate if too long
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: size.height * .02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                alignment: Alignment.topLeft,
                child: Text(
                  list[i].shortDescription as String,
                  maxLines: 2, // Allow wrapping for long titles
                  overflow: TextOverflow.ellipsis, // Truncate if too long
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: size.height * .02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.height * .01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" ${list[i].buyItNowPrice.toString()}",
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      width: size.height * .01,
                    ),
                    Text(" + \$${list[i].startBiddingPrice.toString()}",
                        style: Theme.of(context).textTheme.titleMedium!),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _total(BuildContext context, Size size) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "QTY 1",
                      style: Theme.of(context).textTheme.titleMedium,
                    ))),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {}, child: const Text("Remove")))),
          ],
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "items (2)",
                      style: Theme.of(context).textTheme.titleMedium,
                    ))),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topRight,
                    child: Text(
                      "Us 35.99",
                      style: Theme.of(context).textTheme.titleLarge,
                    ))),
          ],
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ))),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topRight,
                    child: Text(
                      "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ))),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.height * .01),
          width: double.infinity,
          child: const Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Subtotal",
                      style: Theme.of(context).textTheme.titleLarge,
                    ))),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height * .01),
                    alignment: Alignment.topRight,
                    child: Text(
                      list[0].buyItNowPrice.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ))),
          ],
        ),
        ElevatedButtonWidget(
            bgColor: Colors.greenAccent,
            buttonSize: null,
            function: () {
              _showCheckoutModal(context);
            },
            buttonText: "Check out")
      ],
    );
  }

  void _showCheckoutModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: const CheckOutScreen(),
        );
      },
    );
  }

  Widget __section4(BuildContext context, Size size) {
    List<ItemEntity> list =
        BlocProvider.of<GetitemsBloc>(context).getLocalList();
    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      return SizedBox(
        width: double.infinity,
        height: size.height * .7, // Fixed height for ListView
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length, // Adjust number of items based on your data
          itemBuilder: (context, index) {
            return ProductOverViewWidget(
              size: size,
              itemEntity: list[index],
              blocStates: state,
            );
          },
        ),
      );
    });
  }
}
