import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getrecentlyviewed_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/StateMangement/Blocs/getsaveditems_bloc.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/HistoryWidets/favsellers.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/HistoryWidets/recent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../AppCores/CoreWidgets/appbartitle.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetsaveditemsBloc>(context).getSavedItems();
    BlocProvider.of<GetRecentlyViewditemsBloc>(context).getRecentItems();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: const [CartNotificationWidget()],
          centerTitle: true,
          title: const AppBarTtile(),
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
            const Center(
                child: RecentScreen(
              id: 0,
            )),
            const Center(
                child: RecentScreen(
              id: 1,
            )),
            Center(
                child: FavSellerWidet(
              id: 3,
            )),
          ],
        ),
      ),
    );
  }
}
