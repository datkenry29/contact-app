

import 'package:contact_app/screens/add_screen/add_screen.dart';
import 'package:contact_app/screens/main_screen/main_sceen.dart';
import 'package:get/get.dart';

class GetRouter {
  static const String home = '/home';
  static const String detail = '/add';

  static List<GetPage<dynamic>> pages = [
    GetPage(name: home, page: () => const MainScreen(title: "Contact App")),
    GetPage(name: detail, page: () => AddScreen(notifyChangeData: () {}))
  ];
}