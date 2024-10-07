import 'package:education_managment/view/grid%20screens/alerts_screen.dart';
import 'package:education_managment/view/grid%20screens/discloture_screen.dart';
import 'package:education_managment/view/grid%20screens/informationBank_screen.dart';
import 'package:education_managment/view/grid%20screens/marks_screen.dart';
import 'package:education_managment/view/grid%20screens/time_table_screem.dart';
import 'package:education_managment/view/gridScreenSupervisor/ClassSelectionScreen.dart';
import 'package:education_managment/view/gridScreenSupervisor/addSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../gridScreenSupervisor/AddPdfScreen.dart';
import '../../gridScreenSupervisor/AddStudyPlanScreen.dart';
import '../../gridScreenSupervisor/AddTeacherScheduleScreen.dart';
import '../../gridScreenSupervisor/AddTeacherScreen.dart';
import '../../gridScreenSupervisor/AddTeacherToClassScreen.dart';
import '../../gridScreenSupervisor/GradeSelectionScreen.dart';
import '../../gridScreenSupervisor/PaymentClassSelectionScreen.dart';
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
            Get.toNamed(RoutesPath.signup);
          },
          image: AssetsImages.bank,
          imageSize: 130,
          imageColor: AppColors.primaryColor,
          label: "تسجيل طالب جديد",
        ),

        GridItem(
          function: () {
            Get.to(ClassSelectionScreen());
          },
          image: AssetsImages.test,
          label: "إضافة علامات للطلاب",
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(AddPdfScreen());
          },
          label: "إضافة ملفات PDF لبنك المعلومات",
          image: AssetsImages.book,

          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(PaymentClassSelectionScreen());
          },
          label: "إضافة دفعة مالية",
          icon: Icon(
            Icons.attach_money_outlined,
            size: 100,
            color: AppColors.primaryColor,
          ),

          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(AddStudyPlanScreen());
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
          label: "فتح شعب دراسية",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(AddTeacherScreen());
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
        GridItem(
          function: () {
            Get.to(AddTeacherScheduleScreen());
          },
          icon: Icon(
            Icons.timer_outlined,
            size: 100,
            color: AppColors.primaryColor,
          ),          label: "إضافة أوقات للمدرسين",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
        GridItem(
          function: () {
            Get.to(AddClassTeacherScreen());
          },
          icon: Icon(
            Icons.add_box_outlined,
            size: 100,
            color: AppColors.primaryColor,
          ),          label: "إضافة مدرسين للشعب",
          imageSize: 130,
          imageColor: AppColors.primaryColor,
        ),
          GridItem(
            function: () {
              Get.to(GradeSelectionScreen());
            },
            icon: Icon(
              Icons.view_agenda_outlined,
              size: 100,
              color: AppColors.primaryColor,
            ),
            label: "عرض الشعب الدراسية",
            imageSize: 130,
            imageColor: AppColors.primaryColor,
          ),
      ],
    );
  }
}