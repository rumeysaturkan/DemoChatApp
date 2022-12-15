import 'package:chat_app/bindings/ChatViewBinding.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatViewController extends GetxController {
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
