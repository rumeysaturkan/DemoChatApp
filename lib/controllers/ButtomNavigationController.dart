import 'package:chat_app/bindings/ChatViewBinding.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ButtomNavigationController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
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
