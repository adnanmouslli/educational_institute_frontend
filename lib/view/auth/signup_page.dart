import 'package:education_managment/components/custom_button_auth.dart';
import 'package:education_managment/components/custom_text_field.dart';
import 'package:education_managment/components/dropdown_button.dart';
import 'package:education_managment/controller/auth_controller.dart';
import 'package:education_managment/utils/colors.dart';
import 'package:education_managment/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetBuilder<AuthController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "التسحيل الالكتروني",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        AssetsImages.id,
                        color: AppColors.primaryColor,
                        width: 200,
                      ),
                      CustomTextFormField(
                          label: "اسم المستخدم",
                          hint: "اسم المستخدم",
                          iconData: Icons.person,
                          validator: (value) {
                            return "";
                          },
                          controller: controller.username),
                      CustomTextFormField(
                          label: "كلمة المرور",
                          hint: "كلمة المرور",
                          iconData: Icons.lock,
                          validator: (value) {
                            return "";
                          },
                          isPassword: true,
                          controller: controller.password),
                      CustomTextFormField(
                          label: "الاسم الثلاثي",
                          hint: "الاسم الثلاثي",
                          iconData: Icons.edit,
                          validator: (value) {
                            return "";
                          },
                          controller: controller.fullName),
                      CustomTextFormField(
                          label: "اسم المدرسة",
                          hint: "اسم المدرسة",
                          iconData: Icons.school,
                          validator: (value) {
                            return "";
                          },
                          controller: controller.school),
                      CustomTextFormField(
                          label: "رقم الهاتف",
                          hint: "+963 ----------",
                          iconData: Icons.phone_android,
                          validator: (value) {
                            return "";
                          },
                          controller: controller.phone),
                      CustomDropdownButton(
                        hint: "الجنس",
                        values: ["انثى", "ذكر"],
                        onChanged: (value) {
                          controller.gender = value;
                          controller.update();
                        },
                        value: controller.gender,
                      ),
                      CustomDropdownButton(
                        hint: "الفئة الدراسية",
                        values: ["تاسع", "بكلوريا"],
                        onChanged: (value) {
                          controller.classLevel = value;
                          controller.update();
                        },
                        value: controller.classLevel,
                      ),
                      CustomDropdownButton(
                        hint: "الشعبة الدراسية",
                        values: ["2", "1"],
                        onChanged: (value) {
                          controller.idSection = value;
                          controller.update();
                        },
                        value: controller.idSection,
                      ),
                    CustomButton(
                      onPressed: () async {
                        await controller.pickIdImage(); // استدعاء الدالة لاختيار صورة من المعرض
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.idImageFile == null
                                ? "اختر صورة الهوية الشخصية"
                                : "تم اختيار الصورة", // يظهر عند اختيار الصورة
                            style: TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                      CustomButton(
                        color: AppColors.secondaryColor,
                        onPressed: () async {
                          await controller.register();
                        },
                        label: "تثبيت التسجيل",
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
