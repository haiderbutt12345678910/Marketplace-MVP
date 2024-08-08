import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/shimmer_widegt.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/productdetails_sceen.dart';

import '../../../../../../AppCores/BlocStates/blocstates.dart';
import '../../../../../../AppCores/Branding/appcolors.dart';
import 'tags_widegt.dart';

class ProductOverViewWidget extends StatefulWidget {
  final BlocStates? blocStates;
  final Size size;
  final ItemEntity itemEntity;

  const ProductOverViewWidget({
    super.key,
    required this.size,
    this.blocStates,
    required this.itemEntity,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductOverViewWidgetState createState() => _ProductOverViewWidgetState();
}

class _ProductOverViewWidgetState extends State<ProductOverViewWidget> {
  // Track loading state

  @override
  void initState() {
    super.initState();
    // Simulate loading delay, replace this with your actual loading logic
  }

  bool loadFailed = false;

  @override
  Widget build(BuildContext context) {
    return widget.blocStates is Loading
        ? ShimmerWidegt(size: widget.size)
        : _buildActualWidget();
  }

  Widget _buildActualWidget() {
    // Compare and store image URL for the product

    return widget.blocStates is Failure
        ? SizedBox(
            width: double.infinity,
            child: HeadingsWidet.withH1Icon(
              h1: "Failed To Load Data",
              alignment: Alignment.center,
              h2: "Tap here to retry",
              iconData: Icons.refresh,
            ),
          )
        : Container(
            margin: EdgeInsets.only(
                left: widget.size.height * 0.01,
                right: widget.size.height * 0.01,
                top: widget.size.height * 0.01,
                bottom: 0),
            width: widget.size.height * 0.4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.only(),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                            id: widget.itemEntity.id as String,
                          )),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: widget.size.height * .2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        onError: (e, s) {
                          setState(() {
                            loadFailed = true;
                          });
                        },
                        image: NetworkImage(
                          loadFailed
                              ? AppAssetsUrl.fallbackImageUrl
                              : widget.itemEntity.itemImages![0].imageUrl
                                  as String,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: widget.size.height * .12,
                      height: widget.size.height * .05,
                      child: widget.itemEntity.shippingPrice == 0
                          ? TagsWidget(
                              fillColor: true,
                              text: "Sponsored",
                              color: AppColors.sponserd,
                              size: widget.size,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: widget.size.height * .01,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.size.height * .008),
                      child: Text(
                        widget.itemEntity.itemTitle as String,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.size.height * .01,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                      height: 2,
                    ),
                  ),
                  SizedBox(
                    height: widget.size.height * .015,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: widget.size.height * .01),
                  //   child: Row(
                  //     children: [
                  //       const Icon(
                  //         Icons.star,
                  //         color: Colors.amber,
                  //         size: 10,
                  //       ),
                  //       SizedBox(
                  //         width: widget.size.height * .01,
                  //       ),
                  //       Text(
                  //         "3.5/5 (300)",
                  //         style: Theme.of(context).textTheme.titleSmall,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: widget.size.height * .01,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       if (widget.itemEntity.shippingPrice == 0.0)
                  //         TagsWidget(
                  //           text: "Free Shipping",
                  //           color: AppColors.freeShipping,
                  //           size: widget.size,
                  //         ),
                  //       TagsWidget(
                  //         text: "20 % off",
                  //         color: AppColors.discountedsales,
                  //         size: widget.size,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.size.height * .008,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Category: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget
                                        .itemEntity
                                        .categoryEntityItemDetail!
                                        .categoryName as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ],
                            ),
                          ),
                          Text(
                            "RS. ${widget.itemEntity.buyItNowPrice.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColors.discountedsales,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.size.height * .008,
                        vertical: widget.size.height * .008),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type: ${widget.itemEntity.saleType.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(),
                          ),
                          Text(
                              "Condition: ${widget.itemEntity.condition.toString()}",
                              style: Theme.of(context).textTheme.titleSmall!)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
