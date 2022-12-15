import 'package:chat_app/bindings/ChatViewBinding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxBool isDarkTheme = false.obs;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isDarkTheme.value);
  }

  getThemeStatus() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    isDarkTheme.value = (await _isLight.value)!;
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }
}
