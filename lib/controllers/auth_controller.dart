import 'package:trans_app/models/user_model.dart' as AppUser;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_app/providers/auth_api_provider.dart';
import 'package:trans_app/providers/local_storage_provider.dart';


class AuthController extends GetxController {

  final AuthApiProvider authApiProvider;
  final LocalStorageProvider localStorage = Get.find<LocalStorageProvider>();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var authError = ''.obs;
  var userData = Rx<AppUser.User?>(null);

  AuthController({required this.authApiProvider});

  @override
  void onInit() {
    final user = localStorage.getUser();
    if (user != null) {
      userData(user);
      isLoggedIn(true);
    }
    super.onInit();
  }

  Future<void> login(String email, String password) async {
      isLoading(true);
      authError('');
      final response = await authApiProvider.login(email, password);
      if(response != null){
        localStorage.saveToken(response.data['access_token']);
        final user = AppUser.User.fromMap(response.data['user']);
        userData(user);
        localStorage.saveUser(user);
        Get.offAllNamed('/home');
      }  
      isLoading(false);
  }



  Future<void> logout() async {
    try {
      isLoading(true);
      await authApiProvider.logout();
      localStorage.removeUser();
      localStorage.removeToken();
      isLoggedIn(false);
      userData(null);
      Get.offAllNamed('/firstlogin');
    } catch (e) {
      Get.snackbar('Erreur de déconnexion',
          'Impossible de se déconnecter.',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetPassword(String currentPassword, String newPassword, String confirmPassword) async {
    try {
      isLoading(true);
      final response = await authApiProvider.resetPassword(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword);
      if(response?.statusCode == 403){
         isLoading(false);
        Get.snackbar("Erreur", "l'ancien mot de passe est incorrect", backgroundColor: Colors.red, colorText: Colors.white);
      }
      
      if(response?.statusCode == 200){
         isLoading(false);
        Get.snackbar("Modification réussie", "Votre mot de passe a été modifié avec succès", backgroundColor: Colors.green, colorText: Colors.white);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print(e);
    }
  }

}
