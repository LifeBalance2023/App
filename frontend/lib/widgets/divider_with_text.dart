import 'package:flutter/material.dart';

class DividerWithTextWidget extends StatelessWidget {
  final String text;
  final double height;
  final Color textColor;
  final double textSize;

  const DividerWithTextWidget({super.key,
    required this.text,
    this.height = 1.0,
    this.textColor = Colors.black,
    this.textSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
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
              fontSize: textSize,
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
