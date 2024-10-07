import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/ClassGroupController.dart';
import '../../utils/colors.dart';

class ClassGroupsScreen extends StatelessWidget {
  final ClassGroupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Groups'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ClassGroupController>(
        builder: (controller) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.blue.shade200],
            ),
          ),
          child: Obx(() {
            if (controller.classGroups.isEmpty) {
              return const Center(
                child: Text(
                  'No class groups available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.classGroups.length,
              itemBuilder: (context, index) {
                var classGroup = controller.classGroups[index];
                double percentFilled = (classGroup['number-students'] ?? 0) / 30.0;
                bool isSelected = controller.selectedClassGroup.value['id'] == classGroup['id'];

                return GestureDetector(
                  onTap: () {
                    controller.selectClassGroup(classGroup);  // تم تعديل الاسم ليطابق الدالة في الكونترولر
                    controller.fetchClassGroupSchedule(classGroup['id']);
                    controller.update();
                  },
                  child: Card(
                    color: isSelected ? Colors.blue.shade100 : Colors.white,
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.class_,
                                color: AppColors.primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  classGroup['name'] ?? 'Unknown Class',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.grey.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Students: ${classGroup['number-students'] ?? 0} / 30',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: percentFilled,
                            backgroundColor: Colors.grey[200],
                            color: AppColors.primaryColor,
                            minHeight: 8,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Start Date: ${classGroup['start_date'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.grey.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'End Date: ${classGroup['end_date'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          onPressed: controller.selectedClassGroup.value.isNotEmpty
              ? () {
            Get.dialog(ClassScheduleDialog());
          }
              : null,
          child: const Icon(Icons.schedule),
          backgroundColor: controller.selectedClassGroup.value.isNotEmpty
              ? AppColors.primaryColor
              : Colors.grey, // Disable button if no class is selected
        );
      }),
    );
  }
}

class ClassScheduleDialog extends StatelessWidget {
  final ClassGroupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.scheduleData.isEmpty) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'لا يوجد أوقات دوام في هذه الشعبة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Icon(
                  Icons.schedule,
                  size: 50,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        );
      }

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Class Schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(color: Colors.grey, width: 1),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Subject',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...controller.scheduleData.map((subject) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${subject['subjectName']} - الاستاذ ${subject['teacherName']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: subject['dates']
                                .map<Widget>((date) {
                              return Text('${date['day']} - ${date['hour']}');
                            })
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
