import 'package:education_managment/view/grid%20screens/alerts_screen.dart';
import 'package:education_managment/view/grid%20screens/discloture_screen.dart';
import 'package:education_managment/view/grid%20screens/informationBank_screen.dart';
import 'package:education_managment/view/grid%20screens/marks_screen.dart';
import 'package:education_managment/view/grid%20screens/time_table_screem.dart';
import 'package:education_managment/view/gridScreenSupervisor/addSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../gridScreenSupervisor/addAlert.dart';
import 'grid_item.dart';

class BodySupervisor extends StatelessWidget {
  const BodySupervisor({super.key});

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
          label: "برنامج الدوام",
        ),
        GridItem(
          function: () {
            Get.to(MarksScreen());
          },
          image: AssetsImages.test,
          label: "إضافة علامات للطلاب",
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(InformationBankScreen());
          },
          image: AssetsImages.book,
          label: "إضافة ملفات PDF لبنك المعلومات",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(DisclotureScreen());
          },
          image: AssetsImages.bank,
          label: "إضافة خطة دراسية",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(AddSectionScreen());

          },
          image: AssetsImages.bank,
          label: "فتح وإضافة شعب دراسية",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            // Open the add teachers page
          },
          image: AssetsImages.bank,
          label: "إضافة مدرسين للمركز",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(AddAlertScreen());
          },
          icon: Icon(
            Icons.notifications,
            size: 100,
            color: AppColors.primaryColor,
          ),
          label: "إضافة تنبيهات للطلاب",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
