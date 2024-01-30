import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_udemy/src/pages/orders/controller/all_orders_controller.dart';
import 'package:quitanda_udemy/src/pages/orders/view/components/box_order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (_, index) =>
                  BoxOrderTile(order: controller.allOrders[index]),
              itemCount: controller.allOrders.length,
            ),
          );
        },
      ),
    );
  }
}
