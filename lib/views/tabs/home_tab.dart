import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:trans_app/controllers/auth_controller.dart';
import 'package:trans_app/controllers/home_controller.dart';
import 'package:trans_app/models/order_items_response.dart';

class HomeTab extends GetView<HomeController> {


  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade800, Colors.blue.shade200],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenue, ${authController.userData.value?.firstname ?? ''} ${authController.userData.value?.lastname ?? ''}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gérez vos commandes facilement',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildOrderForm(),
                    const SizedBox(height: 16),
                    Obx(() => controller.orderItemByCode.isNotEmpty
                        ? _buildOrderCard(controller.orderItemByCode.first)
                        : Container()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildOrderForm() {
    final TextEditingController orderNumberController = TextEditingController();
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: orderNumberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de commande',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: const Text(
                      "OIT-",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if(orderNumberController.value.text.isEmpty){
                    Get.snackbar("Champs vide", "Veuillez entrer un numéro de commande",backgroundColor: Colors.red,colorText: Colors.white);
                  } else {
                    controller.getOrderItemByCode("OIT-${orderNumberController.value.text}");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Obx( () => controller.isLoadingOrder.value ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                ) : const Text('Rechercher')),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildOrderCard(OrderItems order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(Icons.local_shipping, color: Colors.white),
            ),
            title: Text(
              'Commande #${order.orderItemsCode}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              'Date: ${order.createdAt.toString().split(' ')[0]}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.check_circle, color: Colors.green[400], size: 28),
          ),
          const Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _showStylizedOrderDetailsDialog(order);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Center(
                      child: Text(
                        'Voir les détails',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[300],
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.markOrderAsReceived(order.id ?? 0);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Center(
                      child: Text(
                        'Marquer comme reçu',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showStylizedOrderDetailsDialog(OrderItems order) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Détails de la commande',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Numéro', '#${order.orderItemsCode}'),
                    _buildDetailRow('Date', order.createdAt.toString().split(' ')[0]),
                    _buildDetailRow('Statut', order.statusTransitaireToCity ?? 'N/A'),
                    _buildDetailRow('Quantité', order.quantity?.toString() ?? 'N/A'),
                    _buildDetailRow('Nom', order.product?.name ?? 'N/A'),
                    _buildDetailRow('Prix', order.price?.toString() ?? 'N/A'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade800,
                    ),
                    child: const Text('Fermer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

}
