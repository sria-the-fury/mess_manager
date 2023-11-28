import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';

class InitialProfileUpdate {
  updatePhoto(url, uid) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(url).then((value) =>
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({"photoURL": url}, SetOptions(merge: true)));
  }

  updateDisplayName(name, uid) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name).then((value) =>
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({"displayName": name}, SetOptions(merge: true)));


  }

  updateProfilePhoto(image) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final storageRef = FirebaseStorage.instance.ref('displayPhoto/${currentUser.uid}.jpg');
    await storageRef.putFile(image);

    final downloadUrl = await storageRef.getDownloadURL();

    if (downloadUrl.isNotEmpty) {
      currentUser.updatePhotoURL(downloadUrl);
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
        'photoURL': downloadUrl,
      }, SetOptions(merge: true));
    }
  }

  updateSocialContact (userId, phoneNumber, messengerLink, whatsappNumber) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({
      "phoneNumber" : phoneNumber.length == 11 ? phoneNumber : FieldValue.delete(),
      "messengerLink" : messengerLink.length > 16 ? messengerLink : FieldValue.delete() ,
      "whatsappNumber" : whatsappNumber.length == 11 ? whatsappNumber :  FieldValue.delete(),
    }, SetOptions(merge: true)).then((value) {
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('SOCIAL CONTACT', 'Your social contacts have been added');
    });
  }

  updateProfAndHome (userId, homeTown, role, orgName) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({
      "homeTown" : homeTown.length > 5 ? homeTown : FieldValue.delete(),
      "role" : role.length > 2 ? role : FieldValue.delete() ,
      "orgName" : orgName.length > 5 ? orgName :  FieldValue.delete(),
    }, SetOptions(merge: true)).then((value) {
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('PROF. & HOMETOWN', 'Your Prof and hometown have been added');
    });
  }

  updateDateOfBirth (userId, dob) async{
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({
      "birthday": dob
    }, SetOptions(merge: true)).then((value) {
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('BIRTHDAY', 'Your date of birth has been update');
    });
  }
}
