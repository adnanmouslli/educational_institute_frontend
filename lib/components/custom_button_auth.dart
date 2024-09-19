import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,  this.label, required this.onPressed, this.child, this.color, this.radius});

  final String? label;
  final Function() onPressed;
  final Widget? child;
  final Color? color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.symmetric(vertical: 8),
      child: MaterialButton(
        padding: const EdgeInsetsDirectional.all(10),
        minWidth: MediaQuery.of(context).size.width / 1.5,
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular( radius ?? 10))),
        color: color ?? AppColors.primaryColor,
        onPressed: onPressed,
        child: child ?? Text(
          label ?? '',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
