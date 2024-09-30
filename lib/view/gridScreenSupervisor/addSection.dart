import 'package:education_managment/controller/SectionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSectionScreen extends StatelessWidget {
  final SectionController controller = Get.put(SectionController());

  AddSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة شعبة جديدة'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: GetBuilder<SectionController>(
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
                        // إدخال اسم الشعبة
                        const Text(
                          'اسم الشعبة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'أدخل اسم الشعبة',
                            prefixIcon: Icon(Icons.class_, color: Colors.blue.shade700),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // اختيار الصف
                        const Text(
                          'الصف',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedClass.value,
                          items: controller.classOptions.map((String className) {
                            return DropdownMenuItem<String>(
                              value: className,
                              child: Text(className),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedClass.value = newValue!;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'اختر الصف',
                          ),
                        )),
                        const SizedBox(height: 20),

                        // تاريخ البداية
                        const Text(
                          'تاريخ البداية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.startDateController,
                          readOnly: true,
                          onTap: () => controller.selectDate(context, true),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'اختر تاريخ البداية',
                            prefixIcon: Icon(Icons.date_range, color: Colors.blue.shade700),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // تاريخ الانتهاء
                        const Text(
                          'تاريخ الانتهاء',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.endDateController,
                          readOnly: true,
                          onTap: () => controller.selectDate(context, false),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'اختر تاريخ الانتهاء',
                            prefixIcon: Icon(Icons.date_range, color: Colors.blue.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // زر إرسال الشعبة
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.submitSection();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'إضافة الشعبة',
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
