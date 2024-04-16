import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt intialPage = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  RxList<dynamic> allCategories = RxList<dynamic>([]);
  RxMap<String, dynamic> allproducts = RxMap<String, dynamic>();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
