import 'package:flutter/foundation.dart';

class TeamStatusProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
