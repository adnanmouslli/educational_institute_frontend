import 'package:education_managment/utils/app_routes.dart';
import 'package:education_managment/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/supervisorModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class HeaderSupervisor extends StatelessWidget {
  const HeaderSupervisor({super.key, required this.supervisorModel});

  final SuperviosrModel supervisorModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: 
              Icon(
                Icons.person,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "المشرف : ${supervisorModel.username}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    supervisorModel.isAdmin == 1
                        ? Icons.star
                        : Icons.person_outline,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    supervisorModel.isAdmin == 1 ? "مشرف رئيسي" : "مشرف عادي",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  CacheHelper.sharedPreferences.clear();
                  Get.offNamed(RoutesPath.auth);
                },
                icon: const Icon(Icons.logout, color: Colors.black),
                label: const Text(
                  "تسجيل الخروج",
                  style: TextStyle(color: Colors.black , fontSize: 10),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
