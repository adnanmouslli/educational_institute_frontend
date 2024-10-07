import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/TeacherScheduleController.dart';

class AddTeacherScheduleScreen extends StatelessWidget {
  final TeacherScheduleController controller = Get.put(TeacherScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة أوقات للمدرسين'),
        backgroundColor: Colors.teal, // Updated color
        elevation: 0,
      ),
      body: GetBuilder<TeacherScheduleController>(
        builder:(controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اختر المدرس',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedTeacher.value.isNotEmpty
                        ? controller.selectedTeacher.value
                        : null,
                    hint: Text('اختر المدرس'),
                    isExpanded: true,
                    underline: SizedBox(),
                    items: controller.allTeachers.map((teacher) {
                      return DropdownMenuItem(
                        value: teacher['id'].toString(),
                        child: Text(teacher['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedTeacher.value = value!;
                      controller.fetchTeacherSubjects(); // Fetch subjects for the selected teacher
                    },
                  ),
                )),
                SizedBox(height: 20),

                // اختيار المادة
                Text(
                  'اختر المادة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal),
                    ),
                    child: DropdownButton<String>(
                      value: controller.selectedSubject.value.isNotEmpty
                          ? controller.selectedSubject.value
                          : null,
                      hint: Text('اختر المادة'),
                      isExpanded: true,
                      underline: SizedBox(),
                      items: controller.teacherSubjects.map((subject) {
                        return DropdownMenuItem(
                          value: subject['id_subject'].toString(),
                          child: Text(subject['subjectName']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedSubject.value = value!;
                      },
                    ),
                  );
                }),
                SizedBox(height: 20),

                // اختيار اليوم
                Text(
                  'اختر اليوم',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedDay.value.isNotEmpty
                        ? controller.selectedDay.value
                        : null,
                    hint: Text('اختر اليوم'),
                    isExpanded: true,
                    underline: SizedBox(),
                    items: controller.daysOfWeek.map((day) {
                      return DropdownMenuItem(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedDay.value = value!;
                    },
                   ),
                  )
                ),
                SizedBox(height: 20),

                // اختيار الساعة
                Text(
                  'اختر الساعة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedTime.value.isNotEmpty
                        ? controller.selectedTime.value
                        : null,
                    hint: Text('اختر الساعة'),
                    isExpanded: true,
                    underline: SizedBox(),
                    items: controller.availableTimes.map((time) {
                      return DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedTime.value = value!;
                    },
                  ),
                )),
                SizedBox(height: 30),

                // زر الإضافة
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.blueAccent], // Gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.submitSchedule();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shadowColor: Colors.transparent, // Remove button's default shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'إضافة وقت التدريس',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
