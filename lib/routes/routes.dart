import 'package:chat_app/bindings/LoginViewBinding.dart';

import 'package:get/get.dart';

import '../bindings/ButtomNavigationBinding.dart';
import '../bindings/ChatViewBinding.dart';
import '../bindings/UsersViewBinding.dart';
import '../views/ButtomNavigation.dart';
import '../views/ChatView.dart';
import '../views/LoginView.dart';
import '../views/UsersView.dart';

class AppRoutes {
  static String loginScreen = '/login';
  static String initialRoute = '/initialRoute';
  static String ChatScreen = '/Chat';
  static String UsersScreen = '/Users';
  static String buttomNavigation = '/Navigation';

  static List<GetPage> pages = [
    GetPage(
      name: loginScreen,
      page: () => LoginView(),
      bindings: [
        LoginViewBinding(),
      ],
    ),
    GetPage(
      name: UsersScreen,
      page: () => UsersView(),
      bindings: [
        UsersViewBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => LoginView(),
      bindings: [
        LoginViewBinding(),
      ],
    ),
    GetPage(
      name: buttomNavigation,
      page: () => ButtomNavigationView(),
      bindings: [
        ButtomNavigationBinding(),
      ],
    ),
  ];
}
