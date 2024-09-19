import 'package:education_managment/view/grid%20screens/alerts_screen.dart';
import 'package:education_managment/view/grid%20screens/marks_screen.dart';
import 'package:education_managment/view/grid%20screens/time_table_screem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import 'grid_item.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
        GridItem(
            function: () {
              Get.to(TimeTable());
            },
            image: AssetsImages.schedule,
            label: "برنامج الدوام"),
        GridItem(
            function: () {
              Get.to(MarksScreen());
            },
            image: AssetsImages.test,
            label: "الاطلاع على العلامات",
            imageColor: AppColors.primaryColor),
        GridItem(image: AssetsImages.exam, label: "برنامج الامتحان"),
        GridItem(
            image: AssetsImages.book,
            label: "بنك المعلومات",
            imageSize: 130,
            imageColor: AppColors.primaryColor),
        GridItem(
            image: AssetsImages.bank,
            label: "الكشف المالي",
            imageSize: 130,
            imageColor: AppColors.primaryColor),
        GridItem(
            function: () {
              Get.to(AlertsScreen());
            },
            icon: Icon(
              Icons.notifications,
              size: 100,
              color: AppColors.primaryColor,
            ),
            label: "التنبيهات",
            imageSize: 130,
            imageColor: AppColors.primaryColor),
      ],
    );
  }
}
