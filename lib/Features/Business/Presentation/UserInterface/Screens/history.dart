import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ConstStrings/AssetsStrings/assetsurl.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/HistoryWidets/favsellers.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/HistoryWidets/recent.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: const [CartNotificationWidget()],
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(AppAssetsUrl.brandLogo),
          ),
          title: const Text('Sellers Account'),
          bottom: const TabBar(
            isScrollable: true, // Enable scrolling for many tabs
            tabs: [
              Tab(text: 'Recent'),
              Tab(text: 'Saved'),
              Tab(text: 'Favourite Sellers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of each tab
            Center(
                child: RecentScreen(
              id: 0,
            )),
            Center(
                child: RecentScreen(
              id: 1,
            )),
            Center(
                child: FavSellerWidet(
              id: 0,
            )),
          ],
        ),
      ),
    );
  }
}
