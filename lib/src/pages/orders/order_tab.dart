import 'package:flutter/material.dart';
import 'package:quitanda_udemy/src/config/app_data.dart' as appdata;
import 'package:quitanda_udemy/src/pages/orders/components/box_order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemBuilder: (_, index) => OrderTile(order: appdata.orders[index]),
        itemCount: appdata.orders.length,
      ),
    );
  }
}
