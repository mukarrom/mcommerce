import 'package:get/get.dart';

class MainLayoutController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (index == _currentIndex) {
      return;
    }
    _currentIndex = index;
    update();
  }

  void goToCategoryScreen() {
    _currentIndex = 1;
    update();
  }

  void backToHome() {
    _currentIndex = 0;
    update();
  }
}
