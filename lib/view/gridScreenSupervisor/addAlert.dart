import 'package:education_managment/controller/HomeSupervisorController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAlertScreen extends StatelessWidget {
  final SupervisorHomeController controller = Get.put(SupervisorHomeController());

  AddAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة تنبيه للطلاب'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: GetBuilder<SupervisorHomeController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // إدخال رقم الطالب
                        const Text(
                          'رقم الطالب',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.studentNumberController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'أدخل رقم الطالب',
                            prefixIcon: Icon(Icons.person, color: Colors.blue.shade700),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // إدخال عنوان التنبيه
                        const Text(
                          'عنوان التنبيه',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.titleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'أدخل عنوان التنبيه',
                            prefixIcon: Icon(Icons.title, color: Colors.blue.shade700),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // إدخال نص التنبيه
                        const Text(
                          'نص التنبيه',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.bodyController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'أدخل نص التنبيه',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.message, color: Colors.blue.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // زر إرسال التنبيه
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.submitAlert();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'إضافة التنبيه',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
