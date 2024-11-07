
import 'package:get/get.dart';
import 'package:trans_app/controllers/auth_controller.dart';
import 'package:trans_app/providers/auth_api_provider.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
   
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider());
    Get.lazyPut<AuthController>(() => AuthController(
      authApiProvider: Get.find<AuthApiProvider>(),
    ));
  }
}
