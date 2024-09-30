import 'package:education_managment/utils/app_routes.dart';
import 'package:education_managment/utils/colors.dart';
import 'package:education_managment/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_button_auth.dart';

class MainAuth extends StatelessWidget {
  const MainAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
            child: Container(
              width: 400,
              height: 450,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 10,
                      strokeAlign: 1)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsImages.student,
                      color: AppColors.primaryColor,
                    ),
                    CustomButton(
                      label: "تسجيل الدخول كطالب",
                      onPressed: () {
                        Get.toNamed(RoutesPath.loginStudent);
                      },
                    ),
                    CustomButton(
                      label: "تسجيل الدخول كمشرف",
                      onPressed: () {
                        Get.toNamed(RoutesPath.loginSupervisor);
                      },
                    ),
                    CustomButton(
                      label: "تسجيل الإلكتروني",
                      onPressed: () {
                        Get.toNamed(RoutesPath.signup);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
