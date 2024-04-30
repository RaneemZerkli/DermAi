import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final RxBool onLastPage = false.obs;

  void onPageChanged(int index) {
    onLastPage.value = (index == 2);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
