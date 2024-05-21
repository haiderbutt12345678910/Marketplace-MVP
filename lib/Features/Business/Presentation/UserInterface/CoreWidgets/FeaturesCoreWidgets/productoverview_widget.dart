import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/productdetails_sceen.dart';
import 'package:flutter_application_ebay_ecom/productdummy.dart';

import '../../../../../../AppCores/Branding/appcolors.dart';
import 'shimmer_widegt.dart';
import 'tags_widegt.dart';

class ProductOverViewWidget extends StatefulWidget {
  final Size size;
  final ProductDummy productDummy;

  const ProductOverViewWidget(
      {super.key, required this.size, required this.productDummy});

  @override
  // ignore: library_private_types_in_public_api
  _ProductOverViewWidgetState createState() => _ProductOverViewWidgetState();
}

class _ProductOverViewWidgetState extends State<ProductOverViewWidget> {
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    // Simulate loading delay, replace this with your actual loading logic
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false; // Set loading state to false when data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? ShimmerWidegt(size: widget.size) // Show shimmer when loading
        : _buildActualWidget(); // Show actual widget when loaded
  }

  Widget _buildActualWidget() {
    String productImageUrl = '';

    // Compare and store image URL for the product
    for (var category in catlist) {
      for (var subCat in category.subCategoryDummy as List<SubCategoryDummy>) {
        if (subCat.subCatId == widget.productDummy.subCatId) {
          productImageUrl = subCat.subCatImage as String;
          break;
        }
      }
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widget.size.height * 0.01,
        vertical: widget.size.height * 0.01,
      ),
      width: widget.size.height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                      productDummy: widget.productDummy,
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
                  image: NetworkImage(
                    productImageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: widget.size.height * .12,
                height: widget.size.height * .05,
                child: widget.productDummy.isSponsored as bool
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
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.size.height * .04),
              child: Text(
                widget.productDummy.title as String,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
            SizedBox(
              height: widget.size.height * .01,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.size.height * .01),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 10,
                  ),
                  SizedBox(
                    width: widget.size.height * .01,
                  ),
                  Text(
                    "${widget.productDummy.rating.toString()}/5 ${widget.productDummy.totalRating.toString()} . ${widget.productDummy.soldItems} sold",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.size.height * .01,
              ),
              child: Row(
                children: [
                  if (widget.productDummy.isFreeShipping as bool)
                    TagsWidget(
                      text: "Free Shipping",
                      color: AppColors.freeShipping,
                      size: widget.size,
                    ),
                  TagsWidget(
                    text: "20 % off",
                    color: AppColors.discountedsales,
                    size: widget.size,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                top: widget.size.height * .01,
                left: widget.size.height * .01,
              ),
              child: RichText(
                text: TextSpan(
                  text: ' Bid Price Rs. ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.productDummy.bidPrice,
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
                      text: '${widget.productDummy.bidTime}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
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
