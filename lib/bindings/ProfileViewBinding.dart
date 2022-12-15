import 'package:get/get.dart';
import '../controllers/ProfileViewController.dart';

class ProfileViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProfileViewController>(() => ProfileViewController());
  }
}
