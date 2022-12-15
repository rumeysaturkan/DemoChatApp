import 'package:get/get.dart';
import '../controllers/UsersViewController.dart';

class UsersViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<UsersViewController>(() => UsersViewController());
  }
}
