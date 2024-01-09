import 'package:flutter/material.dart';

class FormTextfieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String? fieldName;
  final String hintText;
  final bool obscureText;

  const FormTextfieldComponent({
    Key? key,
    required this.controller,
    this.fieldName,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fieldName != null) ...[
            Text(
              fieldName!,
              style: const TextStyle(
                fontFamily: 'JejuGothic',
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          TextField(
            controller: controller,
            obscureText: obscureText,
            cursorColor: const Color(0xFF604E5E),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF91778F),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFA68DA4),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              fillColor: const Color(0xFFD9D9D9),
              filled: true,
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
