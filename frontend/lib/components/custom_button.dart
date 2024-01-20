import 'package:flutter/material.dart';

class CustomButtonComponent extends StatelessWidget {
  final String text;
  final String? iconPath;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const CustomButtonComponent({
    Key? key,
    required this.text,
    this.iconPath,
    required this.onPressed,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: const Color(0xFF4A4E69),
        foregroundColor: const Color(0xFFF2E9E4),
        shadowColor: const Color(0xFF62667C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: iconPath == null
          ? Text(
              text,
              style: const TextStyle(
                fontFamily: 'JejuGothic',
                fontSize: 20.0,
                color: Color(0xFFF2E9E4),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath!,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'JejuGothic',
                    fontSize: 20.0,
                    color: Color(0xFFF2E9E4),
                  ),
                ),
              ],
            ),
    );
  }
}
