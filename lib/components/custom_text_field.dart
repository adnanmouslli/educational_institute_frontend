import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.hint,
      required this.iconData,
      required this.validator,
      required this.controller,
      this.textInputType,
      this.isPassword});

  final String label;
  final String hint;
  final IconData iconData;
  final String Function(String? value) validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: isPassword ?? false,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(
              iconData,
              color: AppColors.primaryColor,
            )),
        validator: (value) {
          if(value!.isEmpty){
            validator;
          }else{
            return null;
          }
        },
      ),
    );
  }
}
