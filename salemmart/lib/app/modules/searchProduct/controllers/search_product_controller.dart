import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString searchTerm = RxString("");

  RxMap<String, dynamic> searchedProduct = RxMap<String, dynamic>();
  @override
  void onInit() {
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
