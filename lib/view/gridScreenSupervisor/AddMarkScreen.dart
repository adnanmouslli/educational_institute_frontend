import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/addMarkController.dart';

class AddMarkScreen extends StatelessWidget {
  final bool isT9;
  final addMarkController controller = Get.put(addMarkController());

  AddMarkScreen({Key? key, required this.isT9}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة علامة للطلاب'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Select student dropdown
              const Text('اختر الطالب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedStudent.value.isNotEmpty
                      ? controller.selectedStudent.value
                      : null, // Ensure value is present
                  onChanged: (value) {
                    controller.selectedStudent.value = value ?? '';
                  },
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('اختر الطالب'),
                    ),
                    ...((isT9 ? controller.allStudentT : controller.allStudentB)
                        .map<DropdownMenuItem<String>>((student) {
                      return DropdownMenuItem<String>(
                        value: student['id'].toString(),
                        child: Text(student['full_name']),
                      );
                    }).toList()),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Select subject dropdown
              const Text('اختر المادة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedSubject.value.isNotEmpty
                      ? controller.selectedSubject.value
                      : null,
                  onChanged: (value) {
                    controller.selectedSubject.value = value ?? '';
                  },
                  items: [
                    const DropdownMenuItem<String>(
                      value: '',
                      child: Text('اختر المادة'),
                    ),
                    ...((isT9 ? controller.allSubjectT : controller.allSubjectB)
                        .map<DropdownMenuItem<String>>((subject) {
                      return DropdownMenuItem<String>(
                        value: subject['id'].toString(),
                        child: Text(subject['name']),
                      );
                    }).toList()),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Select mark type dropdown
              const Text('نوع العلامة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedMarkType.value.isNotEmpty
                      ? controller.selectedMarkType.value
                      : null,
                  onChanged: (value) {
                    controller.selectedMarkType.value = value ?? '';
                  },
                  items: const [
                    DropdownMenuItem(value: '', child: Text('اختر نوع العلامة')),
                    DropdownMenuItem(value: 'quiz1', child: Text('Quiz 1')),
                    DropdownMenuItem(value: 'quiz2', child: Text('Quiz 2')),
                    DropdownMenuItem(value: 'midterm', child: Text('Midterm')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Add mark input field
              const Text('أدخل العلامة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: controller.markController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل العلامة',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.addMark(); // Functionality to add mark
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue.shade700,
                  ),
                  child: const Text(
                    'إضافة العلامة',
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
    );
  }
}
