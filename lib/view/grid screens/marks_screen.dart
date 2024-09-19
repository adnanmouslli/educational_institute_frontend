import 'package:education_managment/controller/home_controller.dart';
import 'package:education_managment/utils/colors.dart';
import 'package:education_managment/utils/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    controller.getAllMarks();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'العلامات',
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.marks.isEmpty) {
            return const Center(
              child: Text('No marks available'),
            );
          }

          return ListView.builder(
            itemCount: controller.marks.length,
            itemBuilder: (context, index) {
              final mark = controller.marks[index];
              return Padding(
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
                      // Left colored bar
                      Container(
                        width: 15,
                        height: 100,
                        decoration: BoxDecoration(
                          color: double.parse(mark.mark ?? "0")
                              .getColorForGrade(),
                          borderRadius: BorderRadius.only(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                mark.subject_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "المشرف",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        mark.supervisor_name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "الدرجة",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        mark.grade.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "التاريخ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        mark.date ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.grey[300]
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(height: 8),
                              CircularPercentIndicator(
                                backgroundWidth: 9,
                                backgroundColor: Colors.grey.shade200,
                                radius: 35,
                                lineWidth: 5.0,
                                percent: double.parse(mark.mark ?? "0") / 100,
                                center: new Text("${mark.mark}%"),
                                progressColor: double.parse(mark.mark ?? "0")
                                    .getColorForGrade(),
                              )
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
