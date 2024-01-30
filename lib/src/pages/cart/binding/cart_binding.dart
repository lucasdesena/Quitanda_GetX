import 'package:get/get.dart';
import 'package:quitanda_udemy/src/pages/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
