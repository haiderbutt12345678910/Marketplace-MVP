import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/circularprogess.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getcategories_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/products_overview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<GetCategoriesBloc>(context, listen: false);
    bloc.getCat();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Categories",
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
      body: BlocBuilder<GetCategoriesBloc, BlocStates>(
        builder: (ctx, state) {
          if (state is Loading) {
            return const ProgressCircularIndicatorCustom();
          } else if (state is Sucessfull) {
            return _categories(ctx, size);
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
                      h1: "Error Occured",
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

  Widget _categories(BuildContext context, Size size) {
    var catList = BlocProvider.of<GetCategoriesBloc>(context).getLocalList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * .03),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * .851,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: .5,
              ),
              itemCount: catList.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductsOverview()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * .01),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(catList[index].thumbnail as String),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Text(
                          catList[index].categoryName as String,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: size.height * .03,
          ),
        ],
      ),
    );
  }
}
