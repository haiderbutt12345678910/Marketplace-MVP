import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/ScreenSizeUtils/screensize.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Presentation/UserInterface/CoreWidgets/FeaturesCoreWidgets/cartnotification.dart';

import '../../../../../AppCores/CoreWidgets/appbartitle.dart';

class MassegedOverView extends StatelessWidget {
  MassegedOverView({super.key});

  final list = [
    [
      Icons.favorite_outlined,
      'Saved',
    ],
    [
      Icons.refresh,
      'Buy Again',
    ],
    [
      Icons.pan_tool_sharp,
      'Bids and offers',
    ],
  ];
  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeUtil.getScreenSized(context);
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTtile(),
          elevation: 0,
          actions: const [CartNotificationWidget()],
          centerTitle: true,
        ),
        body: SizedBox(
            height: size.height,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (ctx, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      trailing: index % 2 == 0
                          ? CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text(
                                "1",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          : null,
                      leading: const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://tse4.mm.bing.net/th?id=OIP.BwHcg0ki1TiNyU_ihIV-SgHaHa&pid=Api&P=0&h=220")),
                      title: Text(
                        "Card RushInc",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: index % 2 == 0
                                ? FontWeight.bold
                                : FontWeight.w300),
                      ),
                    ),
                  );
                })));
  }
}
