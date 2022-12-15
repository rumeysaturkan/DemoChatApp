import 'package:chat_app/bindings/ChatViewBinding.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterViewController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

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
    } else if (password.length > 15) {
      return "Too longer";
    } else if (password.length <= 5 && password.length > 0) {
      return "Very short";
    } else {
      return null;
    }
  }

  String? checkFullname(var fullname) {
    if (fullname.length == 0) {
      return "Name Surname can't be empty";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    super.dispose();
  }
}
