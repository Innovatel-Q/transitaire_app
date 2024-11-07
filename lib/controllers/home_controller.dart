import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_app/models/order_items_response.dart';
import 'package:trans_app/models/order_response.dart' ;
import 'package:trans_app/providers/order_provider.dart';

class HomeController extends GetxController {

  final OrderApiProvider orderApiProvider;
  final orderNumberController = TextEditingController();
  final orders = <Datum>[].obs;
  final filteredOrders = <Datum>[].obs;
  final currentFilter = 'Tous'.obs;
  final isAscending = true.obs;
  final orderItemByCode = <OrderItems>{}.obs;
  final isLoading = false.obs;
  final isLoadingOrder = false.obs;
  HomeController({required this.orderApiProvider});

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    ever(orders, (_) => _applyFilter());
    ever(currentFilter, (_) => _applyFilter());
    ever(isAscending, (_) => _applyFilter());
  }

  void loadOrders() {
    getOrderItems();
  }

  Future<void> markOrderAsReceived(int orderId) async {
  final response =  await orderApiProvider.markOrderItemAsReceived(orderId);
    if(response?.statusCode == 200){
      Get.snackbar("mise a jours statuts", "la commande a bien ete mise a jour",backgroundColor: Colors.green,colorText: Colors.white);
      loadOrders();
      orderItemByCode.removeWhere((order) => order.id == orderId);
    }
  }

  Future<void> refreshOrders() async {
    await getOrderItems();
  }

  void setFilter(String filter) {
    currentFilter.value = filter;
    _applyFilter();
  }

  void toggleSortOrder() {
    isAscending.value = !isAscending.value;
    _applyFilter();
  }

  Future<void> markOrderAsSent(int orderId) async {
    final response = await orderApiProvider.markOrderItemAsSent(orderId);
    if (response?.statusCode == 200) {
      Get.snackbar(
        "mise a jours statuts",
        "la commande a bien ete mise a jour",
        backgroundColor: Colors.green,
        colorText: Colors.white
      );
      final index = orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        orders[index].statusTransitaireToCity = "send by forwarder";
        orders.refresh();
      }
    }
  }

  Future<void> getOrderItemByCode(String code) async {
    try {
      isLoadingOrder.value = true;
      final response = await orderApiProvider.getOrderItemByCode(code);
      if (response?.statusCode == 200) {
        final orderItem = OrderItems.fromJson(response?.data['data']);
        if(orderItem.statusTransitaireToCity?.toLowerCase() == 'pending'){
           orderItemByCode.add(orderItem);
        } else {
          Get.snackbar("Commande non trouvée", "La commande avec le code $code n'existe pas",backgroundColor: Colors.red,colorText: Colors.white);
          orderItemByCode.clear();
        }
      } else {
        throw Exception('Échec de la récupération de l\'article : ${response?.statusCode}');
      }
    } catch (e) {
      isLoadingOrder.value = false;
      Get.snackbar(
        "Erreur",
        "Impossible de récupérer l\'article avec le code $code",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoadingOrder.value = false;
  }

  Future<void> getOrderItems() async {
    try {
      isLoading.value = true;
      final response = await orderApiProvider.getOrderItems();
      if (response?.statusCode == 200) {
        OrderItemsList orderItemsResponseList = OrderItemsList.fromJson(response?.data);
        orders.assignAll(orderItemsResponseList.data.where((order) =>
            order.statusTransitaireToCity == "received by forwarder" ||
            order.statusTransitaireToCity == "send" ||
            order.statusTransitaireToCity == "received" ||
            order.statusTransitaireToCity == "send by forwarder"
        ).toList());
      } else {
        throw Exception('Failed to load orders: ${response?.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Impossible de récupérer les commandes: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool send(int id){
    return orders.firstWhere((order) => order.id == id).statusTransitaireToCity == "send"
     || orders.firstWhere((order) => order.id == id).statusTransitaireToCity == "send by forwarder";
  }

  bool received(int id){
    return orders.firstWhere((order) => order.id == id).statusTransitaireToCity == "received"
     || orders.firstWhere((order) => order.id == id).statusTransitaireToCity == "received by forwarder";
  }

  String getStatus(String status) {
    switch (status) {
      case "received" || "received by forwarder":
        return "recu";
      case "send" || "send by forwarder":
        return "envoye";
      case "received by client":
        return "recu par le client";
      default:
        return status;
    }
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case "received" || "received by forwarder":
        return Colors.red;
      case "send" || "send by forwarder":
        return Colors.green;
      case "received by client":
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  void _applyFilter() {
    filteredOrders.assignAll(orders.where((order) {
      if (currentFilter.value == 'Tous') return true;
      return getStatusForFilter(order.statusTransitaireToCity ?? '') == currentFilter.value;
    }).toList());
    
    filteredOrders.sort((a, b) => isAscending.value
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
  }

  String getStatusForFilter(String status){
    switch (status) {
      case "received" || "received by forwarder":
        return "Reçus";
      case "send" || "send by forwarder":
        return "Envoyés";
      case "received by client":
        return "Recu par le client";
      default:
        return status;
    }
  }


  @override
  void onClose() {
    orderNumberController.dispose();
    super.onClose();
  }
}
