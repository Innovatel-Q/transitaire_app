import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_app/controllers/auth_controller.dart';
import 'package:trans_app/views/change_password_screen.dart';
import 'package:trans_app/views/help_screen.dart';

class SettingTab extends GetView<AuthController> {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingItem(
                    icon: Icons.person,
                    title: 'Profil',
                    onTap: () {
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.lock,
                    title: 'Changer le mot de passe',
                    onTap: () {
                      Get.to(() =>  ChangePasswordScreen());
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.help,
                    title: 'Aide',
                    onTap: () {
                      Get.to(() => const HelpScreen());
                    },
                  ),
                  _buildSettingItem(
                    icon: Icons.exit_to_app,
                    title: 'Déconnexion',
                    onTap: () {
                      controller.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.blue),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}