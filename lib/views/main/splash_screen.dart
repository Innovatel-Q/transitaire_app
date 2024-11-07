import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_app/providers/local_storage_provider.dart';
import 'package:trans_app/routes/app_routes.dart';
import 'package:trans_app/views/main/start_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _animation;


  Future<void> _navigateToNextScreen() async {
    final LocalStorageProvider localStorage = Get.find<LocalStorageProvider>();
    
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return; 

    if (localStorage.isFirstLaunch()) {
      await localStorage.completeFirstLaunch();
      Get.off(() => const StartPage());
    } else {
      final token = localStorage.getToken();
      Get.offAllNamed(token?.isNotEmpty == true ? AppRoutes.HOME : AppRoutes.LOGIN);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToNextScreen());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: const Icon(
                Icons.local_shipping, 
                size: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'TransAfrikababba',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'Gestion des commandes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
