import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;
  final RxBool _animationFinished = true.obs;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;
  bool get animationFinished => _animationFinished.value;

  @override
  void onInit() {
    super.onInit();

    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  setAnimationValue(bool newValue) {
    _animationFinished.value = newValue;
  }

  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;
    //Checa se está na home pois só nela existe a animação
    if (_currentIndex.value == 0) {
      //Checa se a animação acabou de ser executada
      if (_animationFinished.value) {
        _pageController.jumpToPage(page);
        _currentIndex.value = page;
      }
    } else {
      _pageController.jumpToPage(page);
      _currentIndex.value = page;
    }
  }
}
