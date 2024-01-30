import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_udemy/src/config/custom_colors.dart';
import 'package:quitanda_udemy/src/config/pages_routes.dart';
import 'package:quitanda_udemy/src/models/item_model.dart';
import 'package:quitanda_udemy/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda_udemy/src/services/utils_services.dart';

class BoxItemTile extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const BoxItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<BoxItemTile> createState() => _BoxItemTileState();
}

class _BoxItemTileState extends State<BoxItemTile> {
  final GlobalKey imageGk = GlobalKey();

  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    if (mounted) setState(() => tileIcon = Icons.check);
    await cartController
        .addItemToCart(item: widget.item)
        .then((_) => widget.cartAnimationMethod(imageGk));
    if (mounted) setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.network(
                          widget.item.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () async {
                  switchIcon();
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
