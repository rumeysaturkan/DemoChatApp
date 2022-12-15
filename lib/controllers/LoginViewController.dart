import 'package:chat_app/bindings/ChatViewBinding.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginViewController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? checkEmail(var email) {
    if (email.length == 0) {
      return "Email can't be empty.";
    } else if (EmailValidator.validate(email) != true) {
      return "Email is invalid";
    } else {
      return null;
    }
  }

  String? checkPassword(var password) {
    if (password.length == 0) {
      return "Passwor can' be empty";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
