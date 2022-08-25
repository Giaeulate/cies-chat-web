import 'package:flutter/cupertino.dart';

class SidebarProvider extends ChangeNotifier {
  int _menuSelected = 0;

  int get menuSelected => _menuSelected;

  set menuSelected(int value) {
    _menuSelected = value;
    notifyListeners();
  }
}
