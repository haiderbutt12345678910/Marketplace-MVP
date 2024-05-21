import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/AppCores/CoreWidgets/pageheadings.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/Screens/products_overview.dart';
import 'package:flutter_application_ebay_ecom/productdummy.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
        body: _categires(context, size));
  }

  Widget _categires(BuildContext context, Size size) {
    const catList = catlist;
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < catList.length; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.height * .03),
              child: Column(
                children: [
                  HeadingsWidet(
                      h1: catList[i].catTitle as String,
                      alignment: Alignment.topLeft),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * .3,
                    // Fixed height for GridView (adjust as needed)
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.height * .32,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: .5),
                      itemCount: catList[i].subCategoryDummy!.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsOverview(
                                        subCatId: catList[i]
                                            .subCategoryDummy![i]
                                            .subCatId as String,
                                        catTitle: catList[i].catTitle as String,
                                        categoryDummy: catList[i],
                                      )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * .01),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    catList[i]
                                        .subCategoryDummy![index]
                                        .subCatImage as String,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .02,
                                ),
                                Text(
                                    catList[i]
                                        .subCategoryDummy![index]
                                        .subCatTitle as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
