import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void removeAndNavigateToRoute(String route) {
    navigationKey.currentState?.popAndPushNamed(route);
  }

  void navigateToRoute(String route) {
    navigationKey.currentState?.pushNamed(route);
  }

  void navigateToPage(Widget page) {
    navigationKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }
  void goBack(){
    navigationKey.currentState?.pop();
  }
}
