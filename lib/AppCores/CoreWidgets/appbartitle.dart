import 'package:flutter/material.dart';

import '../ConstStrings/AssetsStrings/assetsurl.dart';

class AppBarTtile extends StatelessWidget {
  const AppBarTtile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        height: 50,
        margin: const EdgeInsets.only(left: 20),
        child: Image.asset(
          width: 30,
          height: 20,
          AppAssetsUrl.brandLogo,
        ));
  }
}
