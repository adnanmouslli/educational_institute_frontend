import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/TimeTableController.dart';

class TimeTable extends StatelessWidget {
  final TimeTableController controller = Get.put(TimeTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("برنامج الدوام"),
      ),
      body: GetBuilder<TimeTableController>(
        builder: (controller) => ListView.builder(
            itemCount: controller.timeTableData.length,
            itemBuilder: (context, index) {
              var subject = controller.timeTableData[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "المادة: ${subject['subjectName']}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text("المدرس: ${subject['teacherName']}"),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: subject['dates'].map<Widget>((date) {
                          return Text("${date['day']} - ${date['hour']}");
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      );

  }
}
