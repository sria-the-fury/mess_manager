
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitialProfileUpdate{
  updatePhoto(url, uid) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(url).then( (value) => FirebaseFirestore.instance.collection('users').doc(uid).set({
      "photoURL": url

    }, SetOptions(merge: true)));
  }
  updateDisplayName (name, uid) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "displayName": name

    }, SetOptions(merge: true));

  }

}