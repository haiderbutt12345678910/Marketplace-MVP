import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appbartitle.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemDetailsEntity/itemdetail_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../AppCores/Branding/Themes/elevatedbutton_themes.dart';
import '../../../../../AppCores/CoreWidgets/pageheadings.dart';
import '../../../../../productdummy.dart';
import '../../StateMangement/Blocs/getitems_bloc.dart';
import '../CoreWidgets/FeaturesCoreWidgets/productoverview_widget.dart';

class SellerstoreScreen extends StatefulWidget {
  final String? storeName;
  final List<File>? images;
  final ItemDetailEntity itemDetailEntity;

  final bool isMine;
  const SellerstoreScreen(
      {super.key,
      required this.isMine,
      this.images,
      this.storeName,
      required this.itemDetailEntity});

  @override
  State<SellerstoreScreen> createState() => _SellerstoreScreenState();
}

class _SellerstoreScreenState extends State<SellerstoreScreen> {
  final list = [
    ['49%', 'Positive Ratings'],
    ['79%', 'Ship On Time'],
    ['80%', 'Chat Response Rate']
  ];

  final list2 = [
    ['not data', 'Positive Ratings'],
    ['no data', 'Ship On Time'],
    ['no data', 'Chat Response Rate']
  ];

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTtile(),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            _cover(context, size),
            SellerSearchProducts(
              isMine: widget.isMine,
            )
          ],
        ));
  }

  Widget _cover(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * .37,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(AppAssetsUrl.fallbackImageUrl)
                        as ImageProvider,
                    fit: BoxFit.contain)),
            child: Container(
              color: Colors.transparent.withOpacity(.7),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: widget.images != null
                        ? FileImage(File(widget.images![0].path))
                        : const NetworkImage(
                                "https://tse1.mm.bing.net/th?id=OIP.tfaSK3pwhLrecMjEcbcA9gHaHa&pid=Api&P=0&h=220")
                            as ImageProvider),
                title: Text(
                  widget.itemDetailEntity.user!.name == null
                      ? "Store Name"
                      : widget.itemDetailEntity.user!.name as String,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                trailing: ElevatedButton.icon(
                    style: ElevatedButtonsThemesData.darkBg(
                            context, Colors.white12)
                        .copyWith(
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white)),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: null,
                    label: Text(
                      widget.isMine ? "0" : "939123",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.width * .04),
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
                                widget.isMine ? list2[i][0] : list[i][0],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(
                                widget.isMine ? list2[i][1] : list[i][1],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
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
                                color: Colors.white,
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
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * .2,
                ),
                child: ElevatedButtonWidget(
                  buttonSize: null,
                  function: () {
                    if (widget.isMine) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashBoardScreen()),
                      );
                    }
                  },
                  buttonText: widget.isMine ? "View DashBoard" : "Follow",
                  bgColor: Colors.orange,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SellerSearchProducts extends StatefulWidget {
  final bool isMine;

  const SellerSearchProducts({super.key, required this.isMine});

  @override
  State<SellerSearchProducts> createState() => _SellerSearchProductsState();
}

class _SellerSearchProductsState extends State<SellerSearchProducts> {
  String _searchText = '';
  String heading = "All Products";
  String selectedFilter = 'All Products';
  final List<String> filterOptions = [
    'All Products',
    'Free Shipping',
    'Top Rated',
    'Best Selling'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<ProductDummy> filteredList = _getFilteredProducts();

    return Column(
      children: [
        Card(
          shape: const RoundedRectangleBorder(),
          child: SizedBox(
            child: TextField(
              cursorColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                hintText: 'Search In store',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _showModalBottomSheet(context);
                  },
                  icon: const Icon(Icons.more_vert),
                ),
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
        ),
        _lastSection(context, size, filteredList)
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: filterOptions.map((option) {
              return ListTile(
                title: Text(
                  option,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                leading: Radio<String>(
                  activeColor: Colors.orange,
                  value: option,
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                      heading = selectedFilter;
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _lastSection(
      BuildContext context, Size size, List<ProductDummy> filterdlist) {
    if (widget.isMine) {
      return Center(
          child: HeadingsWidet(
        h1: "No Product Found ",
        alignment: Alignment.center,
        h2: "Try Searching Again",
      ));
    }
    if (filterdlist.isEmpty) {
      return Center(
          child: HeadingsWidet(
        h1: "No Product Found ",
        alignment: Alignment.center,
        h2: "Try Searching Again",
      ));
    }

    return _products(context, size, filterdlist);
  }

  Widget _products(BuildContext context, Size size, var list) {
    List<ItemEntity> list =
        BlocProvider.of<GetitemsBloc>(context).getLocalList();
    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      return SizedBox(
          width: double.infinity,
          height:
              size.width * .54, // Fixed height for GridView (adjust as needed)
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
                blocStates: state,
                size: size,
                itemEntity: list[index],
              );
            },
          ));
    });
  }

  List<ProductDummy> _getFilteredProducts() {
    // First filter by the selected filter.
    List<ProductDummy> filteredBySelectedFilter = productList.where((product) {
      switch (selectedFilter) {
        case 'Free Shipping':
          return product.isFreeShipping ?? false;
        case 'Top Rated':
          return product.rating != null && product.rating! >= 4.5;
        case 'Best Selling':
          return product.soldItems != null &&
              int.tryParse(product.soldItems!) != null &&
              int.parse(product.soldItems!) > 100;
        default:
          return true;
      }
    }).toList();

    // Then filter the resulting list by the search text.
    return filteredBySelectedFilter.where((product) {
      // Check if the first 5 words of the title contain the search text.
      return _searchText.isEmpty ||
          _getFirstWords(product.title!)
              .toLowerCase()
              .contains(_searchText.toLowerCase());
    }).toList();
  }

  String _getFirstWords(String text, {int count = 5}) {
    List<String> words = text.split(' ');
    int length = words.length < count ? words.length : count;
    return words.take(length).join(' ');
  }
}
