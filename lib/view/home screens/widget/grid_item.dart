import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, this.image, required this.label, this.imageColor, this.imageSize, this.icon, this.function});

  final String? image;
  final String label;
  final Color? imageColor;
  final double? imageSize;
  final Widget? icon;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:function ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:  const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5),
                    color: AppColors.primaryColor,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal)
              ],
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: icon ??
                    Image.asset(
                    image!,
                    width:imageSize ?? 100,
                    color: imageColor,
                ),
              ),
              const SizedBox(height: 20,),
              Center(child: Padding(
                padding: const EdgeInsets.only(left: 5 ,right: 5 ,bottom: 3),
                child: Text(label, style: AppTextStyle.gridTextStyle),
               )
              )
            ],
          ),
        ),
      ),
    );
  }
}
