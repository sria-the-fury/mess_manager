import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  Stream<Stream<Map<String, dynamic>>> houseData(){
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
        return getSingleHouse(userData['houseId']);
    });
  }

  Stream<Map<String, dynamic>> getSingleHouse(houseId){
    return _firestore.collection('houses').doc(houseId).snapshots().map((documentSnapshot){
      return documentSnapshot.exists ? documentSnapshot.data()! : {};
    });
  }



  Stream<Stream<Stream<List<Map<String, dynamic>>>>> getHouseMembers() {
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
      return _firestore.collection('houses').doc(userData['houseId']).snapshots().map((documentSnapshot){
        final houseData =  documentSnapshot.data()!;
        return _firestore.collection('users').where('houseId', isEqualTo: houseData['houseId']).snapshots().map((querySnapshot) {
          return querySnapshot.docs.map((doc) => doc.data()).toList();
        });
      });
    });
  }
  Stream<Map<String, dynamic>> getUserData(){
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      return documentSnapshot.data()!;
    });
  }
}

