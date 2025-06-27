import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  /// تغییر تب جاری و نوتیفای
  void setIndex(int newIndex) {
    if (_currentIndex != newIndex) {
      _currentIndex = newIndex;
      notifyListeners();
    }
  }
}
