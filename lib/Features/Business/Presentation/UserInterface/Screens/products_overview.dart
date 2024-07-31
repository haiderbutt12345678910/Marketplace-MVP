import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcategories_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getitems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../AppCores/CoreWidgets/appbartitle.dart';
import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({
    super.key,
  });

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  String searchText = '';
  String selectedSubCat = '';
  String selectedSubCatId = '';
  final List<String> _priceSorting = [
    'High to Low',
    'Low To High',
  ];
  final List<String> _checkboxOptions = [
    'New Item',
    'Used Item',
    'Free Shipping',
    'Auction',
    'Price Low to High',
    'Price High to Low'
  ];
  final Map<String, bool> _checkboxValues = {
    'New Item': false,
    'Used Item': false,
    'Free Shipping': false,
    'Auction': false,
    'Price Low to High': true,
    'Price High to Low': false
  };

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCategoriesBloc>(context).getCat();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const AppBarTtile(),
        elevation: 0,
        actions: const [CartNotificationWidget()],
        centerTitle: true,
      ),
      body: BlocBuilder<GetCategoriesBloc, BlocStates>(
        builder: (ctx, state) {
          if (state is Loading) {
            return const ProgressCircularIndicatorCustom();
          } else if (state is Sucessfull) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: _widget(context, size),
            );
          } else {
            return InkWell(
              onTap: () {
                BlocProvider.of<GetCategoriesBloc>(context).getCat();
              },
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeadingsWidet(
                      h1: "Error Occurred",
                      alignment: Alignment.center,
                      h2: "Failed To Load Data Tap To Retry!",
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _searchWidget(BuildContext context, Size size) {
    return Container(
      color: Colors.orangeAccent,
      child: TextField(
        cursorColor: Colors.black,
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        decoration: InputDecoration(
          suffixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          fillColor: Colors.white.withOpacity(.9),
          filled: true,
          hintText: 'Search Products',
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
    );
  }

  Widget _fiters(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .08, vertical: size.width * .01),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * .02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _checkboxOptions.map((option) {
                return Column(
                  children: [
                    Text(option),
                    Checkbox(
                      value: _checkboxValues[option],
                      onChanged: (bool? value) {
                        setState(() {
                          _checkboxValues[option] = value ?? false;
                        });
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selcetCategories(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0),
      child: CustomDropdown<String>(
        hintText: 'Select category',
        items: const ['Category 1', 'Category 2', 'Category 3'],
        decoration: CustomDropdownDecoration(
          closedBorder: const Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
          expandedBorder: const Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
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

  Widget _widget(BuildContext context, Size size) {
    var catList = BlocProvider.of<GetCategoriesBloc>(context).getLocalList();

    // if (selectedSubCat.isEmpty && selectedSubCatId.isEmpty) {
    //   selectedSubCat = catList[0].subCategoryName;
    //   selectedSubCatId = catList[0].id;
    // }

    return Column(
      children: [
        _searchWidget(context, size),
        _selcetCategories(context, size)
      ],
    );
  }

  // Widget __categories(
  //     BuildContext context, Size size, List<SubCategoryEntity> catList) {
  //   return Card(
  //     child: SizedBox(
  //       height: size.height * .25, // Fixed height for ListView
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount:
  //             catList.length, // Adjust number of items based on your data
  //         itemBuilder: (context, index) {
  //           // Replace with your actual product data

  //           return InkWell(
  //             onTap: () {
  //               setState(() {
  //                 selectedSubCat = catList[index].subCategoryName;
  //                 selectedSubCatId = catList[index].id;
  //               });
  //             },
  //             child: Card(
  //               child: Container(
  //                 width: size.width *
  //                     .35, // Fixed width for each item (adjust if needed)
  //                 margin: EdgeInsets.only(right: size.height * .02),
  //                 child: Column(
  //                   children: [
  //                     // Image
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(20),
  //                         color: Colors.white,
  //                       ),
  //                       height: size.height * .15,
  //                       width: double.infinity,
  //                       child: SizedBox(
  //                           height: size.height * .11,
  //                           child: Image.network(
  //                             AppAssetsUrl
  //                                 .fallbackImageUrl, // Primary image URL
  //                             width: double.infinity,
  //                             errorBuilder: (BuildContext context,
  //                                 Object exception, StackTrace? stackTrace) {
  //                               // Return a different image when loading fails
  //                               return Image.network(
  //                                 AppAssetsUrl
  //                                     .fallbackImageUrl, // Fallback image URL
  //                                 width: double.infinity,
  //                                 fit: BoxFit.cover,
  //                               );
  //                             },
  //                           )),
  //                     ),
  //                     SizedBox(
  //                         height: size.height *
  //                             .02), // Spacing between image and text

  //                     // Title
  //                     Container(
  //                       margin:
  //                           EdgeInsets.symmetric(horizontal: size.height * .01),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         catList[index].subCategoryName,
  //                         maxLines: 2, // Allow wrapping for long titles
  //                         overflow:
  //                             TextOverflow.ellipsis, // Truncate if too long
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .titleLarge!
  //                             .copyWith(fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
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
  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Column(
      children: [_lastSection(context, size)],
    );
  }

  Widget _lastSection(BuildContext context, Size size) {
    List<ItemEntity> filteredList = BlocProvider.of<GetitemsBloc>(context)
        .getsubCatFiltered(widget.subCatId)
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

    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      return SizedBox(
        width: double.infinity,
        height: size.height * .6,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: .7,
          ),
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return ProductOverViewWidget(
              blocStates: state,
              size: size,
              itemEntity: filteredList[index],
            );
          },
        ),
      );
    });
  }
}
