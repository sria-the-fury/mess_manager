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
    final currentUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({"displayName": name}, SetOptions(merge: true)).then((value) => currentUser.updateDisplayName(name));

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
      "phoneNumber" : phoneNumber,
      "messengerLink" : messengerLink,
      "whatsappNumber" : whatsappNumber,
    }, SetOptions(merge: true)).then((value) {
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('SOCIAL CONTACT', 'Your social contacts have been added');
    });

  }
}
