import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Stream<Map<String, dynamic>>> houseData(userId){
    return _firestore.collection('users').doc(userId).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
        return getSingleHouse(userData['houseId']);
    });

  }
  Stream<Map<String, dynamic>> getSingleHouse(userId){
    return _firestore.collection('houses').doc(userId).snapshots().map((documentSnapshot){
      return documentSnapshot.exists ? documentSnapshot.data()! : {};
    });
  }



  Stream<List<Map<String, dynamic>>> getHouseData(userId) {
    return _firestore.collection('houses').where('createdBy', isEqualTo: userId).snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }
  Stream<Map<String, dynamic>> getUserData(userId){
    return _firestore.collection('users').doc(userId).snapshots().map((documentSnapshot){
      return documentSnapshot.data()!;
    });
  }
}

