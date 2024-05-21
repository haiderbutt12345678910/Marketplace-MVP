import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/topbannerads.dart';

import '../../../../../productdummy.dart';
import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class ProductsOverview extends StatelessWidget {
  final String subCatId;
  final CategoryDummy categoryDummy;
  final String catTitle;
  const ProductsOverview(
      {super.key,
      required this.catTitle,
      required this.categoryDummy,
      required this.subCatId});

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(catTitle),
          elevation: 0,
          actions: const [CartNotificationWidget()],
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(AppAssetsUrl.brandLogo),
          ),
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(), child: _widget(context, size)));
  }

  Widget _widget(BuildContext context, Size size) {
    return Column(
      children: [
        Column(
          children: [
            BannerAdsWidget(
              height: size.height * .2,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            HeadingsWidet(
                h1: "Top Brands in this category",
                alignment: Alignment.centerLeft),
            SizedBox(
              height: size.height * .01,
            ),
            __categories(context, size),
            SizedBox(
              height: size.height * .05,
            ),
          ],
        ),
        SizedBox(
          height: size.height * .6,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeadingsWidet(h1: "Catalogs", alignment: Alignment.centerLeft),
                SearchProducts(
                  catTitle: catTitle,
                  subCatId: subCatId,
                )
              ],
            ),
          ),
        ),
      ],
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

            return Card(
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
                        overflow: TextOverflow.ellipsis, // Truncate if too long
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
            );
          },
        ),
      ),
    );
  }
}

class SearchProducts extends StatefulWidget {
  final String subCatId;
  final String catTitle;

  const SearchProducts(
      {super.key, required this.subCatId, required this.catTitle});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Column(
      children: [
        Container(
          color: Colors.orangeAccent,
          child: TextField(
            cursorColor: Colors.black,
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              fillColor: Colors.orangeAccent,
              filled: true,
              hintText: 'Search In ${widget.catTitle}',
              prefixIcon: const Icon(Icons.search),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        _lastSection(context, size)
      ],
    );
  }

  Widget _lastSection(BuildContext context, Size size) {
    List<ProductDummy> filteredList = productList
        .where((product) =>
            product.subCatId == widget.subCatId &&
            product.title!.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    if (filteredList.isEmpty) {
      return Center(
        child: HeadingsWidet(
          h1: "No Product Found",
          alignment: Alignment.center,
          h2: "Try Searching Again!",
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * .4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: .5,
        ),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return ProductOverViewWidget(
            size: size,
            productDummy: filteredList[index],
          );
        },
      ),
    );
  }
}
