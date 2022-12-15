import 'package:get/get.dart';
import '../controllers/RegisterViewController.dart';

class RegisterViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<RegisterViewController>(() => RegisterViewController());
  }
}
