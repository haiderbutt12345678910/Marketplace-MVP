import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/SavedItems/saveitem_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getrecentlyviewed_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsaveditems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/productdetails_sceen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../StateMangement/Blocs/getitems_bloc.dart';

class RecentScreen extends StatelessWidget {
  final int id;
  const RecentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return id == 0
        ? BlocBuilder<GetRecentlyViewditemsBloc, BlocStates>(
            builder: (ctx, state) {
            var savedListLocal =
                BlocProvider.of<GetRecentlyViewditemsBloc>(context)
                    .getSavedItemsLocal();

            var list = BlocProvider.of<GetitemsBloc>(context)
                .getLocalListRecentlyVied(savedListLocal);

            if (state is Loading) {
              return const ProgressCircularIndicatorCustom();
            }
            if (state is Sucessfull) {
              return SizedBox(
                height: size.height,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return _produtsOverView(context, size, index);
                    }),
              );
            } else {
              return SizedBox(
                height: size.height,
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<GetRecentlyViewditemsBloc>(context)
                        .getRecentItems();
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
          })
        : BlocBuilder<GetsaveditemsBloc, BlocStates>(builder: (ctx, state) {
            var savedListLocal = BlocProvider.of<GetsaveditemsBloc>(context)
                .getSavedItemsLocal();

            var list = BlocProvider.of<GetitemsBloc>(context)
                .getLocalListRecentlyVied(savedListLocal);

            if (state is Loading) {
              return const ProgressCircularIndicatorCustom();
            }
            if (state is Sucessfull) {
              return SizedBox(
                height: size.height,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return _produtsOverView(context, size, index);
                    }),
              );
            } else {
              return SizedBox(
                height: size.height,
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<GetRecentlyViewditemsBloc>(context)
                        .getRecentItems();
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

  Widget _produtsOverView(BuildContext context, Size size, int i) {
    List<SavedItemEntity> list = [];

    if (id == 0) {
      list = BlocProvider.of<GetRecentlyViewditemsBloc>(context)
          .getSavedItemsLocal();
    } else {
      list = BlocProvider.of<GetsaveditemsBloc>(context).getSavedItemsLocal();
    }

    return Column(
      children: [
        SizedBox(
          height: size.height * .03,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                        id: list[i].item.id as String,
                      )),
            );
          },
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
                      list[i].item.itemTitle as String,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * .01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("pkr ${list[i].item.buyItNowPrice.toString()}",
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(
                          width: size.height * .01,
                        ),
                        Text(list[i].item.shippingPrice.toString(),
                            style: Theme.of(context).textTheme.titleSmall!),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.height * .04,
                  ),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}
