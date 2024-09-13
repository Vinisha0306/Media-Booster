import 'package:get/get.dart';

class PageControlController extends GetxController {
  RxInt index = 0.obs;

  void increment({required data}) {
    data++;
    index(data);
    print(index.value);
  }

  void decrement({required data}) {
    data--;
    index(data);
    print(index.value);
  }
}
