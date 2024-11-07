import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:trans_app/controllers/home_controller.dart';
import 'package:trans_app/models/order_response.dart';

class OrderTab extends GetView<HomeController> {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        _buildFilterOptions(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => controller.refreshOrders(),
            child: controller.isLoading.value
              ? const Center(
                child: SpinKitThreeBounce(
                  color: Colors.blue,
                  size: 50,
                ),
              ) :
              controller.filteredOrders.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: controller.filteredOrders.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final order = controller.filteredOrders[index];
                      return _buildOrderItem(order);
                    });
                  },
                ),
          ),
        ),
      ],
    ));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Aucune commande trouvée',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Datum order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        // onTap: () => _showOrderDetails(order),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: controller.getStatus(order.statusTransitaireToCity) == 'recu' ? Colors.red[100] : Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  controller.getStatus(order.statusTransitaireToCity) == 'recu' ? Icons.inventory : Icons.local_shipping,
                  color: controller.getStatus(order.statusTransitaireToCity) == 'recu' ? Colors.red[800] : Colors.green[800],
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text(
                      'Commande #${order.orderItemsCode}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Date: ${order.createdAt.toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(
                        controller.getStatus(order.statusTransitaireToCity) == 'recu' ? 'Reçu' : 'Envoyé',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: controller.getStatus(order.statusTransitaireToCity) == 'recu' ? Colors.red : Colors.green,
                    ),
                  ],
                ),
              ),
              if (controller.getStatus(order.statusTransitaireToCity) == 'recu')
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () => controller.markOrderAsSent(order.id),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.currentFilter.value,
                  onChanged: (String? newValue) {
                    controller.setFilter(newValue!);
                  },
                  items: ['Tous', 'Reçus', 'Envoyés']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                  isExpanded: true,
                  style: TextStyle(color: Colors.blue[800], fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: IconButton(
              icon: const Icon(Icons.sort, color: Colors.blue),
              onPressed: () => controller.toggleSortOrder(),
              tooltip: 'Trier les commandes',
            ),
          ),
        ],
      ),
    );
  }
}