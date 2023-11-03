import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_service.dart';

class FirestoreController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  late Rx<User?> _user;
  final RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> userData = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> houseData = <String, dynamic>{}.obs;

  @override
  void onReady() {
    super.onReady();
    final auth = FirebaseAuth.instance;

    _user = Rx<User?>(auth.currentUser!);
    _user.bindStream(auth.userChanges());
    _firestoreService.houseData(_user.value!.uid).listen((streamData) {
      streamData.listen((event) {
        houseData.assignAll(event);
      });
    });
    _firestoreService.getUserData(_user.value!.uid).listen((streamData) {
      userData.assignAll(streamData);
    });
  }

  @override
  void onClose() {
    super.onClose();
    final userStream = _firestoreService.getUserData(_user.value!.uid).listen((event) {
    });
    userStream.cancel();

  }
}
