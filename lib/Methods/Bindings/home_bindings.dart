import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirestoreController>(() => FirestoreController());
  }
}