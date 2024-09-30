import 'package:education_managment/controller/home_controller.dart';
import 'package:education_managment/view/home%20screens/widget/BodySupervisor.dart';
import 'package:education_managment/view/home%20screens/widget/header.dart';
import 'package:education_managment/view/home%20screens/widget/headerSupervisor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/HomeSupervisorController.dart';
import '../widget/body.dart';

class HomeSupervisorPage extends StatelessWidget {
  const HomeSupervisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SupervisorHomeController());
    return GetBuilder<SupervisorHomeController>(
      builder: (controller) =>  SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeaderSupervisor(
                  supervisorModel: controller.superviosrModel,
                ),
                SizedBox(
                  height: 10,
                ),
                BodySupervisor(),
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
