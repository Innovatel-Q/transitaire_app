
import 'package:get/get.dart';
import 'package:trans_app/controllers/home_controller.dart';
import 'package:trans_app/providers/order_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderApiProvider>(() => OrderApiProvider());
    Get.put(HomeController(orderApiProvider: Get.find<OrderApiProvider>()));
  }
}