import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:education_managment/controller/home_controller.dart';
import 'package:education_managment/utils/colors.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart'; // استيراد مكتبة عرض الـ PDF

class InformationBankScreen extends StatelessWidget {
  const InformationBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    // جلب ملفات PDF بناءً على اسم الصف
    controller.getAllPdfs();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'بنك المعلومات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // عرض مؤشر التحميل إذا كانت البيانات ما زالت قيد التحميل
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.pdfList.isEmpty) {
          // عرض رسالة إذا لم يكن هناك ملفات PDF
          return const Center(
            child: Text('لا توجد ملفات PDF متاحة.'),
          );
        }

        // عرض قائمة ملفات الـ PDFs
        return ListView.builder(
          itemCount: controller.pdfList.length,
          itemBuilder: (context, index) {
            final pdf = controller.pdfList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    Container(
                      width: 10,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pdf['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pdf['description'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "المشرف: ${pdf['id_supervisor']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  "الصف: ${pdf['class']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                      onPressed: () {
                        // فتح ملف PDF عند الضغط
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFViewerScreen(url: pdf['urlPdf']),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String url;

  const PDFViewerScreen({required this.url, Key? key}) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  bool _isLoading = true;
  late PDFDocument _document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  // تحميل ملف الـ PDF من الرابط
  loadDocument() async {
    _document = await PDFDocument.fromURL('http://10.0.2.2/educational_institute/upload-pdf/1039bios_uefi.pdf');
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عرض ملف PDF'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFViewer(
        document: _document,
      ),
    );
  }
}