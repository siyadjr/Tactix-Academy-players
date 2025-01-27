import 'package:flutter/foundation.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 1;
  bool _isNavBarVisible = true; // Add a variable to track visibility

  int get selectedIndex => _selectedIndex;
  bool get isNavBarVisible => _isNavBarVisible;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleNavBarVisibility() {
    _isNavBarVisible = !_isNavBarVisible;
    notifyListeners();
  }
}
