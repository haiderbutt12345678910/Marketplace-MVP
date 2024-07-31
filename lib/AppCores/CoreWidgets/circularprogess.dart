import 'package:flutter/material.dart';

class ProgressCircularIndicatorCustom extends StatelessWidget {
  final Color? bgColor;
  const ProgressCircularIndicatorCustom({super.key, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.grey.withOpacity(.3),
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.greenAccent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
      ),
    );
  }
}
