import 'package:get/get.dart';
import 'package:quitanda_udemy/src/pages/auth/view/cadastro_page.dart';
import 'package:quitanda_udemy/src/pages/auth/view/login_page.dart';
import 'package:quitanda_udemy/src/pages/base/base_page.dart';
import 'package:quitanda_udemy/src/pages/base/binding/navigation_binding.dart';
import 'package:quitanda_udemy/src/pages/cart/binding/cart_binding.dart';
import 'package:quitanda_udemy/src/pages/home/binding/home_binding.dart';
import 'package:quitanda_udemy/src/pages/orders/binding/orders_binding.dart';
import 'package:quitanda_udemy/src/pages/product/product_page.dart';
import 'package:quitanda_udemy/src/pages/splash/splash_screen.dart';

abstract class Pages {
  static final pages = <GetPage>[
    GetPage(
      page: () => ProductPage(),
      name: Routes.productRoute,
    ),
    GetPage(
      page: () => const SplashScreen(),
      name: Routes.splashRoute,
    ),
    GetPage(
      page: () => LoginPage(),
      name: Routes.loginRoute,
    ),
    GetPage(
      page: () => CadastroPage(),
      name: Routes.cadastroRoute,
    ),
    GetPage(
      page: () => const BasePage(),
      name: Routes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

abstract class Routes {
  static const String productRoute = '/product';
  static const String loginRoute = '/login';
  static const String cadastroRoute = '/cadastro';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
