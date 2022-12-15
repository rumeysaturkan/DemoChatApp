import 'package:get/get.dart';

import '../controllers/ChatViewController.dart';

class ChatViewBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatViewController>(() => ChatViewController());
  }
}
