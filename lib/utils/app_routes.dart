import 'package:education_managment/utils/cache_helper.dart';
import 'package:education_managment/view/auth/loginStudent.dart';
import 'package:education_managment/view/auth/loginSupervisor.dart';
import 'package:education_managment/view/auth/main_auth.dart';
import 'package:education_managment/view/auth/signup_page.dart';
import 'package:education_managment/view/home%20screens/student/home_page.dart';
import 'package:get/get.dart';

import '../view/home screens/supervisor/page_supervisor.dart';

class AppRoutes {
  static final List<GetPage> namedRoutes = [
    GetPage(
      name: RoutesPath.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RoutesPath.homeSupervisor,
      page: () => const HomeSupervisorPage(),
    ),
    GetPage(
      name: RoutesPath.auth,
      page: () => const MainAuth(),
    ),
    GetPage(
      name: RoutesPath.loginStudent,
      page: () => LoginStudent(),
    ),
    GetPage(
      name: RoutesPath.loginSupervisor,
      page: () => LoginSupervisor(),
    ),
    GetPage(
      name: RoutesPath.signup,
      page: () => SignupPage(),
    ),
  ];
}

class RoutesPath {

  // student
  static const home = '/home';
  static const auth = '/auth';
  static const loginStudent = '/loginStudent';
  static const signup = '/signup';


  // supervisor
  static const homeSupervisor = '/homeSupervisor';
  static const loginSupervisor = '/loginSupervisor';


}

class RouteWrapper {
  static get getInitialRoute {

    if(CacheHelper.getData(key: "student")==null && CacheHelper.getData(key: "supervisor") == null) {
      return RoutesPath.auth;
    } else if (CacheHelper.getData(key: "supervisor") != null) {
      return RoutesPath.homeSupervisor;
    }
    else{
      return RoutesPath.home;
    }
  }
}
