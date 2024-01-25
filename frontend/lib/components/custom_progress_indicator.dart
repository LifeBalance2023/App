import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        heightFactor: 2,
        child: CircularProgressIndicator(
      color: Color(0xFF81767F),
      strokeWidth: 5.0,
    ));
  }
}
