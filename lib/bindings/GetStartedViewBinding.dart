import 'package:get/get.dart';
import '../controllers/GetStartedViewController.dart';

class GetStartedViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetStartedViewController>(() => GetStartedViewController());
  }
}
