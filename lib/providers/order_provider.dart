import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_app/providers/api_provider.dart';

class OrderApiProvider{

  ApiProvider apiProvider = ApiProvider();


  Future<dio.Response?> markOrderItemAsReceived(int id) async {
    try {
      final response = await apiProvider.dio.patch(
        '/order-items/$id/status-transitaire',
        data: {"status_transitaire": "received"},
      );
      return response;
    } catch (e) {
      throw Exception('Erreur lors du marquage de l\'article comme reçu : $e');
    }
  }

  Future<dio.Response?> markOrderItemAsSent(int id) async {
    try {
      final response = await apiProvider.dio.patch(
        '/order-items/$id/status-transitaire',
        data: {"status_transitaire": "send"},
      );
      return response;
    } catch (e) {
      throw Exception('Erreur lors du marquage de l\'article comme envoyé : $e');
    }
  }

  
  
  Future<dio.Response?> getOrderItemByCode(String code) async {
    try {
      final response = await apiProvider.dio.get('/order-items/$code');
      if(response.statusCode == 200){
        return response;
      } else {
        throw Exception('Erreur lors de la connexion : ${response.data}');
      }
    } on DioException catch (e) {
      if(e.response?.statusCode == 400){
        Get.snackbar("Commande non trouvée", "La commande avec le code $code n'existe pas",backgroundColor: Colors.red,colorText: Colors.white);
        return null;
      }
      throw Exception('Erreur lors de la connexion : ${e.response?.data}');
    }
  }
  
  Future<dio.Response?> getOrderItems() async {
    try {
      final response = await apiProvider.dio.get('/order-items/forwarder');
      return response;
    } catch (e) {
      throw Exception('Erreur lors de la récupération des articles envoyés : $e');
    }
  }
}