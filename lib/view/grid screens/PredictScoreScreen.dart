import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/predictScoreController.dart';

class PredictScoreScreen extends StatelessWidget {
  final PredictScoreController controllerIm = Get.put(PredictScoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التنبأ بعلامة الفحص النهائي'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: GetBuilder<PredictScoreController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiz 1 input
              _buildInputSection('علامة Quiz 1', controller.quiz1, 0, 100),
              const SizedBox(height: 20),

              // Quiz 2 input
              _buildInputSection('علامة Quiz 2', controller.quiz2, 0, 100),
              const SizedBox(height: 20),

              // Midterm input
              _buildInputSection('علامة الفحص النصفي', controller.midterm, 0, 100),
              const SizedBox(height: 30),

              // Predict button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.predictScore();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue.shade700,
                  ),
                  child: const Text(
                    'التنبؤ بالعلامة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Loading indicator
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        Text(
                          'جاري عملية التنبأ بعلامتك بالفحص النهائي...',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }

                // Display prediction if not loading
                if (controller.predictedFinalScore.value == 0.0) {
                  return Container(); // If no prediction yet, return empty container
                }
                return _buildPredictionDisplay(controllerIm);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(String title, RxDouble score, double min, double max) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Slider(
          value: score.value,
          min: min,
          max: max,
          divisions: 100,
          label: score.value.toString(),
          onChanged: (value) {
            score.value = value;
          },
        ),
      ],
    );
  }

  Widget _buildPredictionDisplay(PredictScoreController controller) {
    String status = '';
    Color statusColor;

    if (controller.predictedFinalScore.value >= 75) {
      status = 'أداء ممتاز!';
      statusColor = Colors.green;
    } else if (controller.predictedFinalScore.value >= 50) {
      status = 'أداء جيد';
      statusColor = Colors.yellow[700]!;
    } else {
      status = 'يحتاج لتحسين';
      statusColor = Colors.red;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'العلامة المتوقعة: ${controller.predictedFinalScore.value.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: statusColor),
          ),
          const SizedBox(height: 10),
          Text(
            'دقة التنبؤ: ${controller.predictionAccuracy.value.toStringAsFixed(2)}%',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: statusColor),
          ),
          const SizedBox(height: 10),
          Icon(
            Icons.star,
            size: 100,
            color: statusColor,
          ),
          const SizedBox(height: 10),
          Text(
            status,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: statusColor),
          ),
        ],
      ),
    );
  }
}
