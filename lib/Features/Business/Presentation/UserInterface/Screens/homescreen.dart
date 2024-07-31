import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/appelevatedbuttons.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
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
                    ],
                  ),
                  SizedBox(
                    height: size.height * .585,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Row(
                          //   children: [
                          //     Expanded(
                          //         child: HeadingsWidet.withRow(
                          //             h1: 'Popular Categories',
                          //             alignment: Alignment.bottomLeft)),
                          //     Expanded(
                          //         child: Container(
                          //       alignment: Alignment.bottomRight,
                          //       child: TextButton(
                          //           onPressed: () {
                          //             Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       const CategoryScreen()),
                          //             );
                          //           },
                          //           child: SizedBox(
                          //             width: size.width * .18,
                          //             height: size.width * .12,
                          //             child: TagsWidget(
                          //                 text: "See All",
                          //                 color: Colors.orangeAccent,
                          //                 size: size),
                          //           )),
                          //     ))
                          //   ],
                          // ),
                          // __categories(context, size),

                          // _freeshipping(context, size),
                          SizedBox(height: size.height * .03),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.height * .02,
                            ),
                            child: HeadingsWidet(
                                h1: 'Recommended Items',
                                alignment: Alignment.bottomLeft),
                          ),
                          SizedBox(height: size.height * .01),
                          _recomendedItems(context, size),

                          SizedBox(height: size.height * .03),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.height * .02,
                            ),
                            child: HeadingsWidet(
                                h1: 'Random Items',
                                alignment: Alignment.bottomLeft),
                          ),
                          SizedBox(height: size.height * .01),
                          _randomItems(context, size),

                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * .1),
                            width: double.infinity,
                            child: ElevatedButtonWidget(
                                buttonSize: null,
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductsOverview()),
                                  );
                                },
                                buttonText: "View All"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _freeshipping(BuildContext context, Size size) {
  //   return BlocBuilder<GetRecentlyViewditemsBloc, BlocStates>(
  //       builder: (ctx, state) {
  //     var savedListLocal = BlocProvider.of<GetRecentlyViewditemsBloc>(context)
  //         .getSavedItemsLocal();

  //     var list = BlocProvider.of<GetitemsBloc>(context)
  //         .getLocalListRecentlyVied(savedListLocal);

  //     return list.isNotEmpty
  //         ? Card(
  //             child: Column(
  //               children: [
  //                 HeadingsWidet(
  //                     h1: "RecentlyViewed", alignment: Alignment.topLeft),
  //                 SizedBox(
  //                   height: size.height * .01,
  //                 ),
  //                 SizedBox(
  //                   height: size.height * .37, // Fixed height for ListView
  //                   child: ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     itemCount: list
  //                         .length, // Adjust number of items based on your data
  //                     itemBuilder: (context, index) {
  //                       // Replace with your actual product data

  //                       return ProductOverViewWidget(
  //                         size: size,
  //                         itemEntity: list[index],
  //                         blocStates: state,
  //                       );
  //                     },
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )
  //         : const SizedBox();
  //   });
  // }

  Widget _recomendedItems(BuildContext context, Size size) {
    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      List<ItemEntity> list =
          BlocProvider.of<GetitemsBloc>(context).getLocalList();

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
    });
  }

  Widget _randomItems(BuildContext context, Size size) {
    return BlocBuilder<GetitemsBloc, BlocStates>(builder: (ctx, state) {
      List<ItemEntity> list =
          BlocProvider.of<GetitemsBloc>(context).getLocalList();

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
    });
  }

  // Widget __categories(BuildContext context, Size size) {
  //   BlocProvider.of<GetCategoriesBloc>(context).getCat();

  //   return BlocBuilder<GetCategoriesBloc, BlocStates>(builder: (ctx, state) {
  //     if (state is Loading) {
  //       return SizedBox(
  //         width: double.infinity,
  //         height: size.height * .25,
  //       );
  //     } else if (state is Sucessfull) {
  //       var catList =
  //           BlocProvider.of<GetCategoriesBloc>(context).getLocalList();

  //       return Card(
  //         child: SizedBox(
  //           height: size.height * .25, // Fixed height for ListView
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount:
  //                 catList.length, // Adjust number of items based on your data
  //             itemBuilder: (context, index) {
  //               // Replace with your actual product data

  //               return InkWell(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => ProductsOverview(
  //                               catId: catList[index].id as String,
  //                             )),
  //                   );
  //                 },
  //                 child: Card(
  //                   child: Container(
  //                     width: size.width *
  //                         .35, // Fixed width for each item (adjust if needed)
  //                     margin: EdgeInsets.only(right: size.height * .02),
  //                     child: Column(
  //                       children: [
  //                         // Image
  //                         Container(
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(20),
  //                             color: Colors.white,
  //                           ),
  //                           height: size.height * .15,
  //                           width: double.infinity,
  //                           child: SizedBox(
  //                             height: size.height * .11,
  //                             child: Image.network(
  //                               catList[index].thumbnail
  //                                   as String, // Primary image URL
  //                               width: double.infinity,
  //                               errorBuilder: (BuildContext context,
  //                                   Object exception, StackTrace? stackTrace) {
  //                                 // Return a different image when loading fails
  //                                 return Image.network(
  //                                   AppAssetsUrl.fallbackImageUrl,
  //                                   width: double.infinity,
  //                                   fit: BoxFit.cover,
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                             height: size.height *
  //                                 .02), // Spacing between image and text

  //                         // Title
  //                         Container(
  //                           margin: EdgeInsets.symmetric(
  //                               horizontal: size.height * .01),
  //                           alignment: Alignment.center,
  //                           child: Text(
  //                             catList[index].categoryName as String,
  //                             maxLines: 2, // Allow wrapping for long titles
  //                             overflow:
  //                                 TextOverflow.ellipsis, // Truncate if too long
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .titleLarge!
  //                                 .copyWith(fontWeight: FontWeight.bold),
  //                           ),
  //                         ),

  //                         // Spacing between title and description

  //                         // Description (optional)
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     } else {
  //       return const SizedBox();
  //     }
  //   });
  // }
}
