import 'package:chat_app/views/LoginView.dart';
import 'package:chat_app/views/RegisterView.dart';
import 'package:chat_app/widgets/CustomButton.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Expanded(child: Image.asset("assets/images/GetStartedImage.png")),
              CustomButton(
                  onPressed: () {
                    Get.to(LoginView());
                  },
                  text: "Sign In"),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  onPressed: () {
                    Get.to(RegisterView());
                  },
                  text: "Sign Up")
            ],
          ),
        ),
      ),
    );
  }
}
