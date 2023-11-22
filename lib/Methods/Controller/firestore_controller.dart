import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_service.dart';

class FirestoreController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final currentUser = FirebaseAuth.instance.currentUser!;

  final RxList<Map<String, dynamic>> membersData = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> houseTodayExpense = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> houseTodayMeals = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> houseYesterdayExpense = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> userData = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> houseData = <String, dynamic>{}.obs;

  @override
  void onReady() {
    super.onReady();

    _firestoreService.getHouseTodayExpense().listen((expenseEvent) {
      expenseEvent.listen((streamData) {
        houseTodayExpense.assignAll(streamData);
      });
    });

    _firestoreService.getHouseTodayMeals().listen((expenseEvent) {
      expenseEvent.listen((streamData) {
        houseTodayMeals.assignAll(streamData);
      });
    });

    _firestoreService.getHouseYesterdayExpense().listen((expenseEvent) {
      expenseEvent.listen((streamData) {
        houseYesterdayExpense.assignAll(streamData);
      });
    });


    _firestoreService.houseData().listen((streamData) {
      streamData.listen((event) {
        houseData.assignAll(event);
      });
    });
    _firestoreService.getUserData().listen((streamData) {
      userData.assignAll(streamData);
    });
    _firestoreService.getHouseMembers().listen((userEvent) {
      userEvent.listen((houseEvent) {
        houseEvent.listen((memberEvent) {
          membersData.assignAll(memberEvent);
        });
      });
    });
  }

  @override
  void onClose() {
    super.onClose();
    final userStream = _firestoreService.getUserData().listen((event) {
    });
    userStream.cancel();

  }
}
