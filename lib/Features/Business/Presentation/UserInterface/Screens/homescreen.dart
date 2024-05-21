import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/tags_widegt.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/topbannerads.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/category_screen.dart';

import '../../../../../productdummy.dart';
import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
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
                  ],
                ),
                SizedBox(
                  height: size.height * .6,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: HeadingsWidet.withRow(
                                    h1: 'Popular Categories',
                                    alignment: Alignment.bottomLeft)),
                            Expanded(
                                child: Container(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CategoryScreen()),
                                    );
                                  },
                                  child: SizedBox(
                                    width: size.width * .13,
                                    height: size.width * .06,
                                    child: TagsWidget(
                                        text: "See All",
                                        color: Colors.orangeAccent,
                                        size: size),
                                  )),
                            ))
                          ],
                        ),
                        __categories(context, size),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.height * .02,
                          ),
                          child: HeadingsWidet(
                              h1: 'Free Shipping',
                              alignment: Alignment.bottomLeft),
                        ),
                        SizedBox(height: size.height * .01),
                        _freeshipping(context, size),
                        SizedBox(height: size.height * .03),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.height * .02,
                          ),
                          child: HeadingsWidet(
                              h1: 'Just For You',
                              alignment: Alignment.bottomLeft),
                        ),
                        SizedBox(height: size.height * .01),
                        _lastSection(context, size),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _lastSection(BuildContext context, Size size) {
    return SizedBox(
        width: double.infinity,
        height:
            size.height * .4, // Fixed height for GridView (adjust as needed)
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // Adjust the max width of each item as needed
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: .5),
          itemCount: productList
              .length, // itemCount should be the total number of items you have
          itemBuilder: (context, int index) {
            return ProductOverViewWidget(
              size: size,
              productDummy: productList[index],
            );
          },
        ));
  }

  Widget _freeshipping(BuildContext context, Size size) {
    List<ProductDummy> list =
        productList.where((element) => element.isFreeShipping == true).toList();
    return Card(
      child: SizedBox(
        height: size.height * .45, // Fixed height for ListView
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length, // Adjust number of items based on your data
          itemBuilder: (context, index) {
            // Replace with your actual product data

            return ProductOverViewWidget(size: size, productDummy: list[index]);
          },
        ),
      ),
    );
  }

  Widget __categories(BuildContext context, Size size) {
    const catList = catlist;

    return Card(
      child: SizedBox(
        height: size.height * .25, // Fixed height for ListView
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              catList.length, // Adjust number of items based on your data
          itemBuilder: (context, index) {
            // Replace with your actual product data

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryScreen()),
                );
              },
              child: Card(
                child: Container(
                  width: size.width *
                      .35, // Fixed width for each item (adjust if needed)
                  margin: EdgeInsets.only(right: size.height * .02),
                  child: Column(
                    children: [
                      // Image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        height: size.height * .15,
                        width: double.infinity,
                        child: SizedBox(
                          height: size.height * .11,
                          child: Image.network(
                            catList[index].catImageURL as String,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: size.height *
                              .02), // Spacing between image and text

                      // Title
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.height * .01),
                        alignment: Alignment.center,
                        child: Text(
                          catList[index].catTitle as String,
                          maxLines: 2, // Allow wrapping for long titles
                          overflow:
                              TextOverflow.ellipsis, // Truncate if too long
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Spacing between title and description

                      // Description (optional)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
