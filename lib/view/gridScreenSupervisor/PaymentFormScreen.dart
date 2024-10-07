import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/paymentController.dart';

class PaymentFormScreen extends StatelessWidget {
  final bool isT9;
  final PaymentController controller = Get.put(PaymentController());

  PaymentFormScreen({Key? key, required this.isT9}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة دفعة مالية'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('اختر الطالب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedStudent.value.isNotEmpty
                      ? controller.selectedStudent.value
                      : null,
                  onChanged: (value) {
                    controller.selectedStudent.value = value ?? '';
                  },
                  items: controller.students.map<DropdownMenuItem<String>>((student) {
                    return DropdownMenuItem<String>(
                      value: student['id'].toString(),
                      child: Text(student['full_name']),
                    );
                  }).toList(),
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
              const Text('أدخل قيمة الدفعة المالية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: controller.paymentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل المبلغ',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.addPayment(); // Functionality to add payment
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue.shade700,
                  ),
                  child: const Text(
                    'إضافة الدفعة',
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
