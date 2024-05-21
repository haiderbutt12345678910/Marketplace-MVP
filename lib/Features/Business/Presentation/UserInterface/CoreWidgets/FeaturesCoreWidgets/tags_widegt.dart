import 'package:flutter/material.dart';

class TagsWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Size size;
  final bool? fillColor;

  const TagsWidget({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: fillColor == null
          ? EdgeInsets.symmetric(
              horizontal: size.height * .01, vertical: size.height * .01)
          : null,
      padding: EdgeInsets.symmetric(
          horizontal: size.height * .01, vertical: size.height * .01),
      decoration: BoxDecoration(
        color: fillColor == null ? null : color,
        border: Border.all(
          color: color, // Change the color here
          width: 1, // Adjust the border width if needed
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: fillColor == null ? color : Colors.white),
      ),
    );
  }
}
