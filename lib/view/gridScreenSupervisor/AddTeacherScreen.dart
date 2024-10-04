import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/TeacherController.dart';

class AddTeacherScreen extends StatelessWidget {
  final TeacherController controller = Get.put(TeacherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة مدرسين للمركز'),
        backgroundColor: Colors.deepPurple, // Updated with a modern color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section title styling
              sectionTitle('اختر الصف'),
              const SizedBox(height: 10),

              // Grade selection
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedGrade.value.isNotEmpty
                      ? controller.selectedGrade.value
                      : null,
                  hint: const Text('اختر الصف'),
                  decoration: _inputDecoration(),
                  items: const [
                    DropdownMenuItem(value: 'تاسع', child: Text('الصف التاسع')),
                    DropdownMenuItem(value: 'بكلوريا', child: Text('البكالوريا')),
                  ],
                  onChanged: (value) {
                    controller.selectedGrade.value = value!;
                  },
                );
              }),

              const SizedBox(height: 20),

              // Teacher name input
              sectionTitle('اسم المدرس'),
              const SizedBox(height: 10),
              TextField(
                decoration: _inputDecoration(labelText: 'اسم المدرس'),
                onChanged: (value) {
                  controller.teacherName.value = value;
                },
              ),

              const SizedBox(height: 20),

              // Teacher specialty input
              sectionTitle('اختصاص المدرس'),
              const SizedBox(height: 10),
              TextField(
                decoration: _inputDecoration(labelText: 'اختصاص المدرس'),
                onChanged: (value) {
                  controller.teacherSpecialty.value = value;
                },
              ),

              const SizedBox(height: 20),

              // Teacher address input
              sectionTitle('عنوان المدرس'),
              const SizedBox(height: 10),
              TextField(
                decoration: _inputDecoration(labelText: 'عنوان المدرس'),
                onChanged: (value) {
                  controller.teacherAddress.value = value;
                },
              ),

              const SizedBox(height: 20),

              // Teacher phone number input
              sectionTitle('رقم هاتف المدرس'),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(labelText: 'رقم هاتف المدرس'),
                onChanged: (value) {
                  controller.teacherPhoneNumber.value = value;
                },
              ),

              const SizedBox(height: 20),

              // Subject selection
              sectionTitle('اختر المواد التي سيدرسها المدرس'),
              const SizedBox(height: 10),
              Obx(() {
                List subjects = controller.selectedGrade.value == 'تاسع '
                    ? controller.allSubjectNinth
                    : controller.allSubjectBaccalaureate;

                return subjects.isNotEmpty
                    ? Wrap(
                  spacing: 8.0,
                  children: subjects.map((subject) {
                    return FilterChip(
                      label: Text(subject['name']),
                      selected: controller.selectedSubjects.contains(subject),
                      onSelected: (isSelected) {
                        controller.toggleSubjectSelection(subject);
                      },
                      backgroundColor: Colors.grey.shade200,
                      selectedColor: Colors.deepPurple.shade200,
                      labelStyle: TextStyle(
                        color: controller.selectedSubjects.contains(subject)
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  }).toList(),
                )
                    : const Center(child: Text('الرجاء اختيار صف أولاً'));
              }),

              const SizedBox(height: 20),

              // Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.submitTeacher();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('إضافة المدرس'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input field decoration
  InputDecoration _inputDecoration({String labelText = ''}) {
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Section title styling
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
    );
  }
}
