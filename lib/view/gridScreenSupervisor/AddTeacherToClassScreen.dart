import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/TeacherClassController.dart';

class AddClassTeacherScreen extends StatelessWidget {

  final ClassTeacherController controller = Get.put(ClassTeacherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة مدرسين إلى الشعب'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // اختيار الصف
              Text('اختر الصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Obx(() => DropdownButton<String>(
                value: controller.selectedGrade.value.isNotEmpty
                    ? controller.selectedGrade.value
                    : null,
                hint: Text('اختر الصف'),
                isExpanded: true,
                items: ['تاسع', 'بكلوريا'].map((grade) {
                  return DropdownMenuItem(
                    value: grade,
                    child: Text(grade),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedGrade.value = value!;
                  controller.selectedSubject.value = '' ;
                  controller.selectedTeacher.value = '' ;
                  controller.selectedClass.value = '' ;
                  controller.fetchClasses(); // جلب الشعب حسب الصف
                  controller.fetchSubjects(); // جلب المواد حسب الصف
                },
              )),
              SizedBox(height: 20),

              // اختيار الشعبة
              Text('اختر الشعبة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Obx(() => DropdownButton<String>(
                value: controller.selectedClass.value.isNotEmpty
                    ? controller.selectedClass.value
                    : null,
                hint: Text('اختر الشعبة'),
                isExpanded: true,
                items: controller.classes.map((classItem) {
                  return DropdownMenuItem(
                    value: classItem['id'].toString(),
                    child: Text(classItem['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedClass.value = value!;
                },
              )),
              SizedBox(height: 20),

              // اختيار المادة
              Text('اختر المادة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Obx(() => DropdownButton<String>(
                value: controller.selectedSubject.value.isNotEmpty
                    ? controller.selectedSubject.value
                    : null,
                hint: Text('اختر المادة'),
                isExpanded: true,
                items: controller.subjects.map((subject) {
                  return DropdownMenuItem(
                    value: subject['id'].toString(),
                    child: Text(subject['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedSubject.value = value!;
                  controller.fetchTeachers(); // جلب المدرسين حسب المادة
                },
              )),
              SizedBox(height: 20),

              // اختيار المدرس
              Text('اختر المدرس', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Obx(() => DropdownButton<String>(
                value: controller.selectedTeacher.value.isNotEmpty
                    ? controller.selectedTeacher.value
                    : null,
                hint: Text('اختر المدرس'),
                isExpanded: true,
                items: controller.teachers.map((teacher) {
                  return DropdownMenuItem(
                    value: teacher['id'].toString(),
                    child: Text(teacher['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedTeacher.value = value!;
                  controller.fetchTeacherSubjects();
                },
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
                      'إضافة المدرس',
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
    );
  }
}
