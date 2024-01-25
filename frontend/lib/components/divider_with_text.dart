import 'package:flutter/material.dart';

class DividerWithTextComponent extends StatelessWidget {
  final String text;
  final double height;
  final Color textColor;
  final double maxTextSize;

  const DividerWithTextComponent({super.key,
    required this.text,
    this.height = 1.0,
    this.textColor = Colors.black,
    this.maxTextSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375.0;
    double scaleFactor = screenWidth / baseWidth;
    double fontSize = (scaleFactor * maxTextSize).clamp(16.0, maxTextSize);

    return Row(
      children: [
        Expanded(
          child: Divider(
            height: height,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: 'JejuGothic',
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: height,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
