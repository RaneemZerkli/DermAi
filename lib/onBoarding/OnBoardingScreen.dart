import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Authentication/login/loginScreen.dart';
import 'IntroScreens/intro1.dart';
import 'IntroScreens/intro2.dart';
import 'IntroScreens/intro3.dart';
import 'OnBoardingController.dart';

class OnBoardingScreen extends StatelessWidget {
  final OnBoardingController _onBoardingController = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _onBoardingController.pageController,
            onPageChanged: _onBoardingController.onPageChanged,
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.8),
            child: Obx(() {
              if (_onBoardingController.onLastPage.value) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    width: 500,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Let's start!",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onBoardingController.pageController.jumpToPage(2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        width: 75,
                        height: 50,
                        child: Center(
                          child: Text(
                            'skip',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _onBoardingController.pageController,
                      count: 3,
                      effect: SlideEffect(activeDotColor: Colors.teal),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onBoardingController.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        width: 75,
                        height: 50,
                        child: Center(
                          child: Text(
                            'next',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
