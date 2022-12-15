import 'package:get/get.dart';
import '../controllers/LoginViewController.dart';

class LoginViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginViewController>(() => LoginViewController());
  }
}
