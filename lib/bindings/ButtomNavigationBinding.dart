import 'package:get/get.dart';

import '../controllers/ButtomNavigationController.dart';
import '../controllers/ChatViewController.dart';

class ButtomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ButtomNavigationController>(() => ButtomNavigationController());
  }
}
