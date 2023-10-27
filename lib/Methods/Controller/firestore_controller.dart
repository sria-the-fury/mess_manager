import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_service.dart';

class FirestoreController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  final RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _firestoreService.getHouseData().listen((streamData) {
      data.assignAll(streamData);
    });
    _firestoreService.getUserData().listen((streamData) {
      userData.assignAll(streamData);
    });
  }

  @override
  void onClose() {
    _firestoreService.getHouseData().listen((event) {
      event.clear();
    });

  }
}
