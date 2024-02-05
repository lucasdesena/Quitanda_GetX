import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_udemy/src/config/custom_colors.dart';
import 'package:quitanda_udemy/src/pages/base/controller/navigation_controller.dart';
import 'package:quitanda_udemy/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda_udemy/src/pages/home/controller/home_controller.dart';
import 'package:quitanda_udemy/src/pages/home/view/components/box_category_tile.dart';
import 'package:quitanda_udemy/src/pages/home/view/components/box_item_tile.dart';
import 'package:quitanda_udemy/src/pages/shared/box_app_name.dart';
import 'package:quitanda_udemy/src/pages/shared/box_shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  final searchController = TextEditingController();
  final navigationController = Get.find<NavigationController>();
  final cartController = Get.find<CartController>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) async {
    runAddToCardAnimation(gkImage);
    await globalKeyCartItems.currentState?.runCartAnimation().then(
      (_) async {
        await globalKeyCartItems.currentState?.updateBadge(
          (cartController.cartItems.length).toString(),
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (cartController.cartItems.isEmpty) await cartController.getCartItems();
      await globalKeyCartItems.currentState?.updateBadge(
        (cartController.cartItems.length).toString(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: globalKeyCartItems,
      jumpAnimation: const JumpAnimationOptions(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      createAddToCartAnimation: (addToCardAnimationMethod) {
        runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const BoxAppName(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 30,
              ),
              child: GetBuilder<CartController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      navigationController
                          .navigatePageView(NavigationTabs.cart);
                    },
                    child: AddToCartIcon(
                      key: globalKeyCartItems,
                      icon: Icon(
                        size: 25,
                        Icons.shopping_cart,
                        color: CustomColors.customSwatchColor,
                      ),
                      badgeOptions: BadgeOptions(
                        active: true,
                        fontSize: 12,
                        height: 20,
                        width: 20,
                        foregroundColor: Colors.white,
                        backgroundColor: CustomColors.customContrastColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquise aqui...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customContrastColor,
                        size: 21,
                      ),
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customContrastColor,
                                size: 21,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 1,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return BoxCategoryTile(
                              onPressed: () async {
                                await controller.selectCategory(
                                    controller.allCategories[index]);
                              },
                              category: controller.allCategories[index].title,
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 12),
                              child: BoxShimmer(
                                height: 20,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? Visibility(
                          visible: (controller.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 40,
                                color: CustomColors.customSwatchColor,
                              ),
                              const Text('Não há itens para apresentar'),
                            ],
                          ),
                          child: RefreshIndicator(
                            onRefresh: controller.getAllCategories,
                            child: GridView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 9 / 11.5,
                              ),
                              itemCount: controller.allProducts.length,
                              itemBuilder: (_, index) {
                                if (((index + 1) ==
                                        controller.allProducts.length) &&
                                    !controller.isLastPage) {
                                  controller.loadMoreProducts();
                                }

                                return BoxItemTile(
                                  item: controller.allProducts[index],
                                  cartAnimationMethod:
                                      itemSelectedCartAnimations,
                                );
                              },
                            ),
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            10,
                            (index) => BoxShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
