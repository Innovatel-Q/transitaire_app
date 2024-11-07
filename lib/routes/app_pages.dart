import 'package:get/get.dart';
import 'package:trans_app/bindings/auth_binding.dart';
import 'package:trans_app/bindings/home_binding.dart';
import 'package:trans_app/routes/app_routes.dart';
import 'package:trans_app/views/auth/login_screen.dart';
import 'package:trans_app/views/tabs/home_screen.dart';
import 'package:trans_app/views/main/splash_screen.dart';
class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),  
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),  
      bindings:[
        HomeBinding(),
        AuthBinding()
      ],
    ),
    GetPage(
      name: AppRoutes.LOGIN,
       page: () =>  LoginScreen(),
       binding: AuthBinding()
    ),
  ];
}
