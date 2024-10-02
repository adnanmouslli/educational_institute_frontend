import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/predictScoreController.dart';

class PerformanceAnalysis extends StatelessWidget {
  final PredictScoreController controller = Get.put(PredictScoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحليل الوضع الدراسي'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.performanceAnalysis.isEmpty) {
            return Center(child: Text('لا توجد بيانات لتحليل الأداء بعد.'));
          }
          return _buildPerformanceAnalysis(controller.performanceAnalysis);
        }),
      ),
    );
  }

  Widget _buildPerformanceAnalysis(var analysis) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تحليل الأداء الشخصي',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Using Cards for better structure
          _buildCard('متوسط العلامات', analysis['quiz_average'], Icons.assessment, Colors.blueAccent),
          _buildCard('علامة الفحص النصفي', analysis['midterm'], Icons.star, Colors.orange),
          _buildCard('العلامة المتوقعة', analysis['final_score_predicted'], Icons.grade, Colors.green),
          const SizedBox(height: 20),

          // Trends
          Text('الاتجاهات', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildTrendCard('الاتجاه من Quiz إلى الفحص النصفي', analysis['quiz_midterm_trend'], Colors.orange),
          _buildTrendCard('الاتجاه من الفحص النصفي إلى النهائي', analysis['midterm_final_trend'], Colors.green),
          const SizedBox(height: 20),

          // Differences
          Text('الفرق بين العلامات', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildDifferenceCard('الفرق بين Quiz والفحص النصفي', analysis['quiz_to_midterm_difference'], Colors.blue),
          _buildDifferenceCard('الفرق بين الفحص النصفي والنهائي', analysis['midterm_to_final_difference'], Colors.red),
        ],
      ),
    );
  }

  Widget _buildCard(String title, dynamic value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(value.toString(), style: TextStyle(fontSize: 22, color: color)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendCard(String title, String trend, Color color) {
    return Card(
      elevation: 2,
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            Text(trend, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildDifferenceCard(String title, dynamic difference, Color color) {
    return Card(
      elevation: 2,
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            Text(difference.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
