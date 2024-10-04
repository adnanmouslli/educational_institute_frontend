import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/StudyPlanController.dart';

class AddStudyPlanScreen extends StatelessWidget {
  final StudyPlanController controller = Get.put(StudyPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة خطة دراسية'),
        backgroundColor: Colors.deepPurple.shade700, // Slightly darker tone for a modern look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grade selection section
              sectionTitle('اختر الصف'),
              const SizedBox(height: 10),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedGrade.value.isNotEmpty
                      ? controller.selectedGrade.value
                      : null,
                  onChanged: (value) {
                    controller.selectedGrade.value = value ?? '';
                    controller.selectedStudent.value = '';

                    // Fetch respective student and subjects based on grade
                    if (value == 'تاسع') {
                      controller.getAllStudentSelectT();
                      controller.getAllSubjectSelectT();
                    } else if (value == 'بكلوريا') {
                      controller.getAllStudentSelectB();
                      controller.getAllSubjectSelectB();
                    }
                  },
                  items: const [
                    DropdownMenuItem<String>(value: 'تاسع', child: Text('تاسع')),
                    DropdownMenuItem<String>(value: 'بكلوريا', child: Text('بكلوريا')),
                  ],
                  decoration: _inputDecoration(),
                );
              }),
              const SizedBox(height: 20),

              // Student selection section
              sectionTitle('اختر الطالب'),
              const SizedBox(height: 10),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedStudent.value.isNotEmpty
                      ? controller.selectedStudent.value
                      : null,
                  onChanged: (value) {
                    controller.selectedStudent.value = value ?? '';
                  },
                  items: controller.selectedGrade.value == 'تاسع'
                      ? controller.allStudentT.map<DropdownMenuItem<String>>((student) {
                    return DropdownMenuItem<String>(
                      value: student['id'].toString(),
                      child: Text(student['full_name']),
                    );
                  }).toList()
                      : controller.allStudentB.map<DropdownMenuItem<String>>((student) {
                    return DropdownMenuItem<String>(
                      value: student['id'].toString(),
                      child: Text(student['full_name']),
                    );
                  }).toList(),
                  decoration: _inputDecoration(),
                );
              }),
              const SizedBox(height: 20),

              // Subjects selection section
              sectionTitle('اختر المواد'),
              const SizedBox(height: 10),
              Obx(() {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0, // Adding space between chips
                      children: controller.selectedGrade.value == 'تاسع'
                          ? controller.allSubjectT.map((subject) {
                        return FilterChip(
                          label: Text(subject['name']),
                          selected: controller.selectedSubjects.contains(subject),
                          onSelected: (isSelected) {
                            controller.toggleSubjectSelection(subject);
                          },
                          backgroundColor: Colors.grey.shade200,
                          selectedColor: Colors.deepPurple.shade300, // Lighter shade for selected chips
                          labelStyle: TextStyle(
                            color: controller.selectedSubjects.contains(subject)
                                ? Colors.white
                                : Colors.black,
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: controller.selectedSubjects.contains(subject)
                                  ? Colors.deepPurple
                                  : Colors.grey.shade400,
                            ),
                          ),
                        );
                      }).toList()
                          : controller.allSubjectB.map((subject) {
                        return FilterChip(
                          label: Text(subject['name']),
                          selected: controller.selectedSubjects.contains(subject),
                          onSelected: (isSelected) {
                            controller.toggleSubjectSelection(subject);
                          },
                          backgroundColor: Colors.grey.shade200,
                          selectedColor: Colors.deepPurple.shade300,
                          labelStyle: TextStyle(
                            color: controller.selectedSubjects.contains(subject)
                                ? Colors.white
                                : Colors.black,
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: controller.selectedSubjects.contains(subject)
                                  ? Colors.deepPurple
                                  : Colors.grey.shade400,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 30),

              // Stylish submit button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.submitStudyPlan();
                  },
                  icon: const Icon(Icons.add_task, size: 24),
                  label: const Text('إضافة الخطة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade500, // Modern button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 36.0),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  // Helper function to style input fields
  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Helper function for section titles
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
