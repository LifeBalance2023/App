import 'package:flutter/material.dart';

class FormTextfieldComponent extends StatelessWidget {
  final String? fieldName;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const FormTextfieldComponent({
    Key? key,
    this.fieldName,
    required this.hintText,
    required this.obscureText,
    this.controller,
    this.validator,
    this.onChanged,
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
          TextFormField(
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
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF6E1010),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF6E1010),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              fillColor: const Color(0xFFD9D9D9),
              filled: true,
              hintText: hintText,
              errorStyle: const TextStyle(
                fontFamily: 'JejuGothic',
                fontSize: 14.0,
                color: Color(0xFF6E1010),
              ),
            ),
            validator: validator,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
