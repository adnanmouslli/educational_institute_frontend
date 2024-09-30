import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:education_managment/controller/home_controller.dart';
import 'package:education_managment/utils/colors.dart';

class DisclotureScreen extends StatelessWidget {
  const DisclotureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    // جلب بيانات الدفعات المالية
    controller.getAllDiscloture();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'الدفعات المالية',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // عرض مؤشر التحميل
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.disclosureList.isEmpty) {
          // عرض رسالة إذا لم تكن هناك دفعات مالية
          return const Center(
            child: Text(
              'لا توجد دفعات مالية مسجلة.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // عرض قائمة الدفعات المالية
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.disclosureList.length,
          itemBuilder: (context, index) {
            final disclosure = controller.disclosureList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black45,
                child: InkWell(
                  onTap: () {
                    // يمكن إضافة وظيفة عند الضغط على البطاقة، مثل عرض تفاصيل أكثر
                  },
                  child: Row(
                    children: [
                      // شريط ملون صغير على الجانب الأيسر لإضافة جمالية
                      Container(
                        width: 8,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.redAccent, // لون مميز للشريط
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // الكمية المدفوعة مع أيقونة نقدية
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${disclosure['paid_quantity']} ل.س',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // اسم المشرف مع أيقونة شخص
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'المشرف: ${disclosure['username']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // تاريخ الدفع مع أيقونة تقويم
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'تاريخ الدفع: ${disclosure['date']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),

    );
  }
}
