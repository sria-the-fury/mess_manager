import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';

class HouseExpense{

  void addDailyExpense(houseId, shoppingItems, currentUserId) async {
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    await FirebaseFirestore.instance.collection('houses').doc(houseId).collection('expenses').doc('$day$month$year').set({
      'id': '$day$month$year',
      'createdAt': DateTime.now(),
      'shoppingItems': shoppingItems,
      'addedBy': currentUserId

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('EXPENSES', 'Today\'s expenses have been added. ');
    });

  }
}