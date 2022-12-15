import 'package:chat_app/Themes/constants.dart';
import 'package:chat_app/controllers/RegisterViewController.dart';
import 'package:chat_app/widgets/CustomButton.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/Authentication.dart';
import 'LoginView.dart';

class RegisterView extends StatefulWidget {
  static var email;
  static var password;
  static var fullname;
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final controller = Get.put(RegisterViewController());
  final AuthController authController = Get.put(AuthController());
  late GlobalKey<FormState> _formKey;

  bool rememberValue = false;

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
                  text: 'Create,\nNew Account',
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
          text: "Name Surname",
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        ),
        SizedBox(
          height: 8,
        ),
        FullnameTextFormField(),
        const SizedBox(
          height: 20,
        ),
        CustomText(
          text: "Email",
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
                Get.to(LoginView());
              },
              child: Text(
                "I  have an account",
                style: TextStyle(color: Color.fromARGB(255, 151, 150, 150)),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                AuthController.AuthInstance.register(
                    controller.fullnameController.text.trim(),
                    controller.emailController.text.trim(),
                    controller.passwordController.text.trim());
              }
            },
            text: "Sign up"),
      ],
    );
  }

  Widget FullnameTextFormField() {
    return TextFormField(
      style: TextStyle(color: purple),
      controller: controller.fullnameController,
      validator: (value) {
        return controller.checkFullname(value);
      },
      onSaved: (input) {
        setState(() {
          RegisterView.fullname = input!;
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

  Widget EmailTextFormField() {
    return TextFormField(
      style: TextStyle(color: purple),
      controller: controller.emailController,
      validator: (value) {
        return controller.checkEmail(value);
      },
      onSaved: (input) {
        setState(() {
          RegisterView.email = input!;
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
          RegisterView.password = input!;
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
