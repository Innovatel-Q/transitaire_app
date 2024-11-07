import 'package:get_storage/get_storage.dart';
import 'package:trans_app/models/user_model.dart';

class LocalStorageProvider {
  // Initialisation du GetStorage
  final _storage = GetStorage();

  final String _tokenKey = 'auth_token_trans_app';
  final String _userKey = 'user_trans';
  final String _isFirstLaunchKey = 'is_first_launch_app_trans_app';

  // Sauvegarder le token d'authentification
  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  // Récupérer le token d'authentification
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  // Supprimer le token d'authentification
  Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
  }

  // Sauvegarder les informations utilisateur (sous forme de Map)
  Future<void> saveUser(User user) async {
    await _storage.write(_userKey, user.toMap());
  }

  // Récupérer les informations utilisateur
  User? getUser() {
    final userMap = _storage.read(_userKey) as Map<String, dynamic>?;
    return userMap != null ? User.fromMap(userMap) : null;
  }

  // Supprimer les informations utilisateur
  Future<void> removeUser() async {
    await _storage.remove(_userKey);
  }

  // Vérifier si c'est la première fois de lancer l'application
  bool isFirstLaunch() {
    return _storage.read(_isFirstLaunchKey) ??
        true; // Renvoie true si la clé n'existe pas encore
  }

// Marquer que l'application a déjà été lancée
  Future<void> completeFirstLaunch() async {
    await _storage.write(
        _isFirstLaunchKey, false); // Écrire false après la première ouverture
  }

  Future<void> clearStorage() async {
    await _storage.erase();
  }


}
