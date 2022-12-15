import 'dart:io';

import 'package:chat_app/Themes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../routes/routes.dart';
import '../../services/Database.dart';

import '../controllers/ProfileViewController.dart';

import '../services/Authentication.dart';
import '../widgets/CustomText.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final profileController = Get.put(ProfileViewController());

  final service = Get.put(AuthController());
  final database = Get.put(Database());
  var size, height, width;

  var data;

  @override
  void initState() {
    //email="";
    //password="";
    profileController.getThemeStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileTopWidget(),
            ProfileProperties(),
          ],
        ),
      ),
    );
  }

  Widget ProfileTopWidget() {
    return SizedBox(
      height: height * 0.50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: height * 0.10,
            backgroundImage: const AssetImage(
              "assets/images/profilePhoto.jpg",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          NameText(),
          const SizedBox(
            height: 10,
          ),
          EmailText(),
        ],
      ),
    );
  }

  Widget ProfileProperties() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dark_mode_outlined,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        text: "Dark Mode",
                        fontSize: context.textTheme.titleLarge!.fontSize,
                      ),
                    ],
                  ),
                  ObxValue(
                    (data) => CupertinoSwitch(
                      value: profileController.isDarkTheme.value,
                      activeColor: purple,
                      onChanged: (val) {
                        profileController.isDarkTheme.value = val;
                        Get.changeThemeMode(
                          profileController.isDarkTheme.value
                              ? ThemeMode.dark
                              : ThemeMode.light,
                        );
                        profileController.saveThemeStatus();
                      },
                    ),
                    false.obs,
                  ),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width * 0.75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        text: "Log Out",
                        fontSize: context.textTheme.titleLarge!.fontSize,
                      )
                    ],
                  ),
                  InkWell(
                      onTap: service.signOut,
                      child: Container(
                          child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: Theme.of(context).primaryIconTheme.size,
                      )))
                ]),
          ),
        ],
      ),
    );
  }

  Widget NameText() {
    return CustomText(
      text: service.currentUser.fullname.toString(),
      fontSize: context.textTheme.headline6!.fontSize,
    );
  }

  Widget EmailText() {
    return CustomText(
      text: service.currentUser.email.toString(),
      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
    );
  }
}
