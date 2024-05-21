import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/Themes/elevatedbutton_themes.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/masseges.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/sellerstore.dart';
import 'package:flutter_application_ebay_ecom/productdummy.dart';

import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductDummy productDummy;
  ProductDetailsScreen({super.key, required this.productDummy});

  final list = [
    ['49%', 'Positive Ratings'],
    ['79%', 'Ship On Time'],
    ['80%', 'Chat Response Rate']
  ];

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            productDummy.title as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          elevation: 0,
          actions: const [CartNotificationWidget()],
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(AppAssetsUrl.brandLogo),
          ),
        ),
        body: Stack(
          children: [
            _widget(context, size),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButtonWidget(
                              bgColor: Colors.greenAccent,
                              buttonSize: null,
                              function: () {},
                              buttonText: "Add To Cart")),
                      Expanded(
                          child: ElevatedButtonWidget(
                              bgColor: Colors.amber,
                              buttonSize: null,
                              function: () {},
                              buttonText: "Buy Now")),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _widget(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _productImages(context, size),
          _prodctOverView(context, size),
          _aboutThisItem(context, size),
          _ratings(context, size),
          _reviews(context, size),
          _aboutSeller(context, size),
          _moreProducts(context, size)
        ],
      ),
    );
  }

  Widget _prodctOverView(BuildContext context, Size size) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .01,
          ),
          HeadingsWidet(
              h1: productDummy.title as String, alignment: Alignment.topCenter),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.height * .01),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(
                      top: size.height * .01,
                      left: size.height * .01,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: ' Bid Price Rs. ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: productDummy.bidPrice,
                            style: Theme.of(context).textTheme.titleLarge!,
                          ),
                          TextSpan(
                            text: '  Ends On  ',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.black),
                          ),
                          TextSpan(
                            text: '${productDummy.bidTime}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 30,
                ),
                SizedBox(
                  width: size.height * .01,
                ),
                Text(
                  "${productDummy.rating.toString()}/5 ${productDummy.totalRating.toString()} . ${productDummy.soldItems} sold",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          Card.filled(
            color: Colors.white70,
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  text: productDummy.isFreeShipping as bool
                      ? "Free Shipping"
                      : "Standad Shipping",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: "   Est. delivery 20 May- 27 May",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              leading: const Icon(
                Icons.local_shipping_sharp,
                color: Colors.black,
              ),
              trailing: const Icon(
                Icons.warning,
                color: Colors.grey,
              ),
            ),
          ),
          Card.filled(
            color: Colors.white,
            child: ListTile(
              title: Text(
                "Money Back Gurantee",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              leading: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              trailing: const Icon(
                Icons.warning,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _productImages(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      height: size.height * .4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(productDummy.images?[0] as String),
              fit: BoxFit.cover)),
    );
  }

  Widget _aboutThisItem(BuildContext context, Size size) {
    return Card(
      child: Column(
        children: [
          HeadingsWidet(h1: "About this item", alignment: Alignment.topLeft),
          SizedBox(
            height: size.height * .01,
          ),
          for (int i = 0; i < productDummy.specifications!.length; i++)
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * .01),
                    child: Text(
                      '${i + 1} ${productDummy.specifications![i]}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _aboutSeller(BuildContext context, Size size) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            HeadingsWidet(h1: "About Seller", alignment: Alignment.topLeft),
            SizedBox(
              height: size.height * .01,
            ),
            ListTile(
              leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://tse4.mm.bing.net/th?id=OIP.BwHcg0ki1TiNyU_ihIV-SgHaHa&pid=Api&P=0&h=220")),
              title: Text(
                "Store Name",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              trailing: ElevatedButton.icon(
                  style:
                      ElevatedButtonsThemesData.darkBg(context, Colors.white12)
                          .copyWith(),
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  onPressed: null,
                  label: Text(
                    "939123",
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * .1, vertical: size.width * .04),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < list.length; i++)
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              list[i][0],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            Text(
                              list[i][1],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        if (i != list.length - 1)
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                          )
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * .01),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * .01,
                    ),
                    child: ElevatedButtonWidget(
                        bgColor: Colors.orange,
                        buttonSize: null,
                        function: () {
                          //to store

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SellerstoreScreen(isMine: false)));
                        },
                        buttonText: "Visit Store"),
                  )),
                  SizedBox(
                    width: size.width * .03,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * .01,
                    ),
                    child: ElevatedButtonWidget(
                        bgColor: Colors.grey,
                        buttonSize: null,
                        function: () {
                          //to store
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MassegedOverView()));
                        },
                        buttonText: "Contact"),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ratings(BuildContext context, Size size) {
    return Card(
      child: Column(
        children: [
          HeadingsWidet(h1: "Product Ratings", alignment: Alignment.topLeft),
          SizedBox(
            height: size.height * .01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.height * .01),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 50,
                ),
                SizedBox(
                  width: size.height * .01,
                ),
                Text(
                  "${productDummy.rating.toString()}/5 ${productDummy.totalRating.toString()}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  width: size.width * .2,
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Quality",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            width: size.width * .04,
                          ),
                          Text(
                            productDummy.rating.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 30,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Price",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            width: size.width * .04,
                          ),
                          Text(
                            productDummy.rating.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviews(BuildContext context, Size size) {
    String rev =
        "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.";
    return Card(
      child: Column(
        children: [
          HeadingsWidet(h1: "Product Reviews", alignment: Alignment.topLeft),
          SizedBox(
            height: size.height * .01,
          ),
          for (int i = 0; i < 3; i++)
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: size.height * .02, vertical: size.height * .02),
              leading: const CircleAvatar(
                radius: 20,
                child: Text(
                  "J",
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: "John Cena",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: " 10-5-2024",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                rev,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  Widget _moreProducts(BuildContext context, Size size) {
    var list = productList;
    return Card(
      child: Column(
        children: [
          HeadingsWidet(h1: "People Also View", alignment: Alignment.topLeft),
          SizedBox(
            height: size.height * .01,
          ),
          SizedBox(
            height: size.height * .4, // Fixed height for ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  list.length, // Adjust number of items based on your data
              itemBuilder: (context, index) {
                // Replace with your actual product data

                return ProductOverViewWidget(
                    size: size, productDummy: list[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
