import 'package:get/get.dart';

class IndexBottomNav extends GetxController {
  var index = 0.obs;
  void changeIndex(int change) => index.value = change;
}
