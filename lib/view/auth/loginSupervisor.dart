import 'package:education_managment/components/custom_button_auth.dart';
import 'package:education_managment/components/custom_text_field.dart';
import 'package:education_managment/components/dropdown_button.dart';
import 'package:education_managment/controller/auth_controller.dart';
import 'package:education_managment/utils/app_routes.dart';
import 'package:education_managment/utils/colors.dart';
import 'package:education_managment/utils/images.dart';
import 'package:education_managment/view/auth/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSupervisor extends StatelessWidget {
  LoginSupervisor({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetBuilder<AuthController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView( // نقل SingleChildScrollView هنا
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: HeaderWidget(250, Icons.person),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'مرحبا بك !',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'أهلاً بك في نظام الإشراف الخاص بالمعهد!',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 30.0),
                          CustomTextFormField(
                            label: "اسم المشرف",
                            hint: "اسم المشرف",
                            iconData: Icons.person,
                            validator: (value) {
                              return "يجب ملئ الحقل";
                            },
                            controller: username,
                          ),
                          CustomTextFormField(
                            label: "كلمة المرور",
                            hint: "كلمة المرور",
                            isPassword: true,
                            iconData: Icons.remove_red_eye,
                            validator: (value) {
                              return "يجب ملئ الحقل";
                            },
                            controller: password,
                          ),
                          CustomButton(
                            radius: 50,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.loginSupervisor(username.text, password.text);
                              }
                            },
                            color: AppColors.secondaryColor,
                            label: "تسجيل الدخول",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
