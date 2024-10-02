import 'package:education_managment/view/grid%20screens/alerts_screen.dart';
import 'package:education_managment/view/grid%20screens/discloture_screen.dart';
import 'package:education_managment/view/grid%20screens/informationBank_screen.dart';
import 'package:education_managment/view/grid%20screens/marks_screen.dart';
import 'package:education_managment/view/grid%20screens/time_table_screem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../grid screens/PredictScoreScreen.dart';
import '../../grid screens/performanceAnalysisScreen.dart';
import 'grid_item.dart';

class Body extends StatelessWidget {

  final HomeController controller ;
  const Body({super.key, required this.controller});

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
            function: () {
              Get.to(InformationBankScreen());
            },
            image: AssetsImages.book,
            label: "بنك المعلومات",
            imageSize: 130,
            imageColor: AppColors.primaryColor),
        GridItem(
            function: () {
              Get.to(DisclotureScreen());
            },
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
        GridItem(
            function: () {
              if(controller.studentModel.classLevel == 'تاسع'){
                if(controller.studentStatus.length == 3 && controller.studentStatus[0]['count'] == 6 && controller.studentStatus[1]['count'] == 6 && controller.studentStatus[2]['count'] == 6 ){
                  Get.to(PredictScoreScreen());
                }
                else {
                  Get.snackbar(
                    'تنبيه', // عنوان التنبيه
                    'لاتستطيع التنبأ بعلامتك الا بعد الانتهاء من الفحص النصفي!!', // نص الرسالة
                    backgroundColor: Colors.yellow[100], // لون خلفية التنبيه
                    colorText: Colors.black, // لون النص
                    icon: Icon(Icons.warning, color: Colors.orange), // أيقونة تنبيه
                    snackPosition: SnackPosition.BOTTOM, // مكان ظهور التنبيه
                    duration: Duration(seconds: 5), // مدة عرض التنبيه
                    isDismissible: true, // يمكن dismiss التنبيه
                    borderRadius: 10, // زوايا دائرية
                    margin: EdgeInsets.all(10), // هوامش حول التنبيه
                    animationDuration: Duration(milliseconds: 300), // مدة التحريك
                    forwardAnimationCurve: Curves.easeInOut, // منحنى التحريك
                  );
                }
              }else {
                if(controller.studentStatus.length == 3 && controller.studentStatus[0]['count'] == 8 && controller.studentStatus[1]['count'] == 8 && controller.studentStatus[2]['count'] == 8 ){
                  Get.to(PredictScoreScreen());
                }
                else {
                  Get.snackbar(
                    'تنبيه', // عنوان التنبيه
                    'لاتستطيع التنبأ بعلامتك الا بعد الانتهاء من الفحص النصفي!!', // نص الرسالة
                    backgroundColor: Colors.yellow[100], // لون خلفية التنبيه
                    colorText: Colors.black, // لون النص
                    icon: Icon(Icons.warning, color: Colors.orange), // أيقونة تنبيه
                    snackPosition: SnackPosition.BOTTOM, // مكان ظهور التنبيه
                    duration: Duration(seconds: 5), // مدة عرض التنبيه
                    isDismissible: true, // يمكن dismiss التنبيه
                    borderRadius: 10, // زوايا دائرية
                    margin: EdgeInsets.all(10), // هوامش حول التنبيه
                    animationDuration: Duration(milliseconds: 300), // مدة التحريك
                    forwardAnimationCurve: Curves.easeInOut, // منحنى التحريك
                  );
                }
              }
            },
            icon: Icon(
              Icons.smart_toy,
              size: 100,
              color: AppColors.primaryColor,
            ),
            label: "التنبأ بعلامة الفحص النهائي",
            imageSize: 130,
            imageColor: AppColors.primaryColor),
        GridItem(
            function: () {
              Get.to(PerformanceAnalysis());
            },
            icon: Icon(
              Icons.analytics_outlined,
              size: 100,
              color: AppColors.primaryColor,
            ),
            label: "تحليل الوضع الدراسي",
            imageSize: 130,
            imageColor: AppColors.primaryColor),
      ],
    );
  }
}
