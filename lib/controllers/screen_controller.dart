import 'package:flutter/material.dart';

class ScreenController extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  void setPage(int index) {
    _changeIndex(index);

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    notifyListeners();
  }

  void _changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void reset() {
    _currentIndex = 0;
  }
}
