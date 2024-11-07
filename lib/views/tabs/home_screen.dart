import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_app/views/tabs/order_tab.dart';
import 'package:trans_app/views/tabs/home_tab.dart';
import 'package:trans_app/views/tabs/setting_tab.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          elevation: 0,
          centerTitle: true,
          title: const Text('TransAfrikababba'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Accueil'),
              Tab(icon: Icon(Icons.list), text: 'Commandes'),
              Tab(icon: Icon(Icons.settings), text: 'Paramètres'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            OrderTab(),
            SettingTab(),
          ],
        ),
      ),
    );
  }


}