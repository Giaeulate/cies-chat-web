import 'package:flutter/cupertino.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

  // static navigateTo(String routeName) {
  //   return navigateKey.currentState!.pushNamed(routeName);
  // }

  static replaceTo(String routeName) {
    return navigateKey.currentState!.pushReplacementNamed(routeName);
  }
}
