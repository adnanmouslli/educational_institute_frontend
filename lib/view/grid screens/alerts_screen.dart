import 'package:education_managment/controller/home_controller.dart';
import 'package:education_managment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    controller.getAllAlerts();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'التنبيهات',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.alerts.isEmpty) {
            return const Center(
              child: Text('No alerts available'),
            );
          }

          return ListView.builder(
            itemCount: controller.alerts.length,
            itemBuilder: (context, index) {
              final alert = controller.alerts[index];
              return
                Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 8,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                alert.body,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "المشرف : ${alert.supervisorName}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    "بتاريخ : ${alert.date}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
