import 'package:education_managment/controller/home_controller.dart';
import 'package:education_managment/view/home%20screens/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (controller) =>  SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Header(
                  studentModel: controller.studentModel,
                ),
                SizedBox(
                  height: 10,
                ),
                Body(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
