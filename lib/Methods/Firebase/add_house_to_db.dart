import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';
import 'package:uuid/uuid.dart';

class AddHouseToDB{

  addHouse(name, location) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final houseId = const Uuid().v4();
    await FirebaseFirestore.instance.collection('houses').doc(houseId).set({
      'houseId' : houseId,
      'houseName' : name,
      'houseLocation' : location,
      'createdBy' : currentUser.uid,
      'houseManager' : currentUser.uid,
      'createdAt' :FieldValue.serverTimestamp(),
      'members' : [currentUser.uid]

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('ADD HOUSE', 'Your house has been added.');
    });
  }
  updateHouse(name, location, houseId) async{
    await FirebaseFirestore.instance.collection('houses').doc(houseId).set({
      'houseId' : houseId,
      'houseName' : name,
      'houseLocation' : location,

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('UPDATE HOUSE', 'Your house has been updated.');
    });

  }

  addMatesToHouse(houseId, houseMateId) async {
    await FirebaseFirestore.instance.collection('users').doc(houseMateId).set({
      'houseId': houseId

    }, SetOptions(merge: true)).then((value) =>
       FirebaseFirestore.instance.collection('houses').doc(houseId).set({
        'members' : FieldValue.arrayUnion([houseMateId])

      }, SetOptions(merge: true))
        .then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('HOUSE MATE', 'Your house mate has been added.');
    }));

  }

  removeMatesFromHouse(houseMateId, houseId, removeBySelf) async {
    await FirebaseFirestore.instance.collection('houses').doc(houseId).set({
      'members' : FieldValue.arrayRemove([houseMateId])

    }, SetOptions(merge: true)).then((value) =>
        FirebaseFirestore.instance.collection('users').doc(houseMateId).set({
          'houseId': FieldValue.delete()

        }, SetOptions(merge: true))
            .then((value){
          Get.back(closeOverlays: true);
          CustomGetSnackbar().warning(removeBySelf == true ?  "LEAVE HOUSE" : "HOUSE MATE",
              removeBySelf == true ? "You have left this house." : 'Your house mate has been removed.');
        }));
  }

  assignHouseManager(houseId, houseMateId) async{
    await FirebaseFirestore.instance.collection('houses').doc(houseId).set({
      'houseManager' : houseMateId

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('HOUSE MANAGER', 'House Manager is aasigned.');
    });

  }

}