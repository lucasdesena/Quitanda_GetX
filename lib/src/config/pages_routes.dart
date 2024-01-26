import 'package:get/get.dart';
import 'package:quitanda_udemy/src/pages/auth/cadastro_page.dart';
import 'package:quitanda_udemy/src/pages/auth/login_page.dart';
import 'package:quitanda_udemy/src/pages/base/base_page.dart';
import 'package:quitanda_udemy/src/pages/product/product_page.dart';

abstract class Pages {
  static final pages = <GetPage>[
    GetPage(
      page: () => ProductPage(),
      name: Routes.productRoute,
    ),
    GetPage(
      page: () => const LoginPage(),
      name: Routes.loginRoute,
    ),
    GetPage(
      page: () => CadastroPage(),
      name: Routes.cadastroRoute,
    ),
    GetPage(
      page: () => const BasePage(),
      name: Routes.baseRoute,
      // bindings: [
      //   NavigationBinding(),
      //   HomeBinding(),
      //   CartBinding(),
      //   OrdersBinding(),
      // ],
    ),
  ];
}

abstract class Routes {
  static const String productRoute = '/product';
  static const String loginRoute = '/login';
  static const String cadastroRoute = '/cadastro';
  static const String baseRoute = '/';
}
