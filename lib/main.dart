import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trans_app/providers/local_storage_provider.dart';
import 'package:trans_app/routes/app_pages.dart';
import 'package:trans_app/routes/app_routes.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
  Get.put(LocalStorageProvider(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TransAfrikababba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false,
      ),
       initialRoute: AppRoutes.INITIAL,
      getPages: AppPages.pages,
    );
  }
}
