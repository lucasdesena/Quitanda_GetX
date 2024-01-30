import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_udemy/src/config/custom_colors.dart';
import 'package:quitanda_udemy/src/models/cart_item_model.dart';
import 'package:quitanda_udemy/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda_udemy/src/pages/shared/box_quantity.dart';
import 'package:quitanda_udemy/src/services/utils_services.dart';

class BoxCartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const BoxCartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  State<BoxCartTile> createState() => _BoxCartTileState();
}

class _BoxCartTileState extends State<BoxCartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: QuantityWidget(
          suffixText: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          result: (quantity) {
            controller.changeItemQuantity(
              item: widget.cartItem,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
