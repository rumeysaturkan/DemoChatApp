import 'package:chat_app/views/ProfileView.dart';
import 'package:chat_app/views/UsersView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ButtomNavigationController.dart';

class ButtomNavigationView extends GetWidget<ButtomNavigationController> {
  @override
  @override
  Widget build(BuildContext context) {
    final ButtomNavigationController buttomNavigationController =
        Get.put(ButtomNavigationController(), permanent: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Obx(
        () => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: IntrinsicHeight(
            child: BottomNavigationBar(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: buttomNavigationController.changeTabIndex,
              currentIndex: buttomNavigationController.tabIndex.value,
              unselectedItemColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedLabelStyle: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedLabelStyle,
              selectedLabelStyle:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Icon(
                      Icons.explore_outlined,
                      size: 25.0,
                    ),
                  ),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Icon(
                      Icons.account_circle_outlined,
                      size: 25.0,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => IndexedStack(
            index: buttomNavigationController.tabIndex.value,
            children: [
              UsersView(),
              ProfileView(),
            ],
          )),
    );
  }
}
