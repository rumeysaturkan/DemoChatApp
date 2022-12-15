import 'package:chat_app/Themes/constants.dart';
import 'package:chat_app/controllers/LoginViewController.dart';
import 'package:chat_app/views/RegisterView.dart';
import 'package:chat_app/widgets/CustomBackButton.dart';
import 'package:chat_app/widgets/CustomButton.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/Authentication.dart';

class LoginView extends StatefulWidget {
  static var email;
  static var password;
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginViewController());
  final AuthController authController = Get.put(AuthController());
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .backgroundColor, //Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(
                  text: 'Hello,\nWelcome',
                  fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  child: FormContent(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Email Addres",
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        ),
        SizedBox(
          height: 8,
        ),
        EmailTextFormField(),
        const SizedBox(
          height: 20,
        ),
        CustomText(
          text: "Password",
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        ),
        SizedBox(
          height: 8,
        ),
        PasswordTextFormField(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: InkWell(
            onTap: () {
              Get.to(RegisterView());
            },
            child: Text(
              "I don't have an account",
              style: TextStyle(color: Color.fromARGB(255, 151, 150, 150)),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                AuthController.AuthInstance.login(
                    controller.emailController.text.trim(),
                    controller.passwordController.text.trim());
              }
            },
            text: "Sign in"),
      ],
    );
  }

  Widget EmailTextFormField() {
    return TextFormField(
      style: TextStyle(color: purple),
      controller: controller.emailController,
      validator: (value) {
        return controller.checkEmail(value);
      },
      onSaved: (input) {
        setState(() {
          LoginView.email = input!;
        });
      },
      maxLines: 1,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: purple, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: darkGray,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: darkGray,
          ),
        ),
      ),
    );
  }

  Widget PasswordTextFormField() {
    return TextFormField(
      style: TextStyle(color: purple),
      validator: (value) {
        return controller.checkPassword(value);
      },
      controller: controller.passwordController,
      onSaved: (input) {
        setState(() {
          LoginView.password = input!;
        });
      },
      maxLines: 1,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: purple, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: darkGray,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: darkGray,
          ),
        ),
      ),
    );
  }
}
