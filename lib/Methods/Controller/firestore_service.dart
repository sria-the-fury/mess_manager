import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getHouseData() {
    return _firestore.collection('houses').where('createdBy', isEqualTo: currentUser.uid).snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }
  Stream<Map<String, dynamic>> getUserData(){
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      return documentSnapshot.data()!;
    });

  }
}

