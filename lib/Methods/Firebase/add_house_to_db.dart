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
      'createdAt' : DateTime.now(),
      'members' : [currentUser.uid]

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('ADD HOUSE', 'Your house has been added.');
    });
  }

}