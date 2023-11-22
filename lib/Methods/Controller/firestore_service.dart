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
        final houseData =  documentSnapshot.data();
        return _firestore.collection('users').where('houseId', isEqualTo: houseData?['houseId'] ?? '').snapshots().map((querySnapshot) {
          return querySnapshot.docs.map((doc) => doc.data()).toList();
        });
      });
    });
  }
  Stream<Stream<Map<String, dynamic>>> getHouseTodayExpense() {
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
      final day = DateTime.now().day;
      final month = DateTime.now().month;
      final year = DateTime.now().year;
      return _firestore.collection('houses').doc(userData['houseId']).collection('expenses').doc('$day$month$year')
          .snapshots().map((documentSnapshot){
        return documentSnapshot.exists ? documentSnapshot.data()! : {};
      });
    });

  }

  Stream<Stream<Map<String, dynamic>>> getHouseTodayMeals() {
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
      final day = DateTime.now().day;
      final month = DateTime.now().month;
      final year = DateTime.now().year;
      return _firestore.collection('houses').doc(userData['houseId']).collection('meals').doc('$day$month$year')
          .snapshots().map((documentSnapshot){
        return documentSnapshot.exists ? documentSnapshot.data()! : {};
      });
    });

  }

  Stream<Stream<Map<String, dynamic>>> getHouseTomorrowMeals() {
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final month = tomorrow.month;
      final year = tomorrow.year;
      return _firestore.collection('houses').doc(userData['houseId']).collection('meals')
          .doc('${tomorrow.day}$month$year')
          .snapshots().map((documentSnapshot){
        return documentSnapshot.exists ? documentSnapshot.data()! : {};
      });
    });

  }

  Stream<Stream<Map<String, dynamic>>> getHouseYesterdayExpense() {
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      final userData = documentSnapshot.data()!;
      final previousDate = DateTime.now().subtract(const Duration(days: 1));
      final month = previousDate.month;
      final year = previousDate.year;
      return _firestore.collection('houses').doc(userData['houseId']).collection('expenses')
          .doc('${previousDate.day}$month$year')
          .snapshots().map((documentSnapshot){
        return documentSnapshot.exists ? documentSnapshot.data()! : {};
      });
    });

  }


  Stream<Map<String, dynamic>> getUserData(){
    return _firestore.collection('users').doc(currentUser.uid).snapshots().map((documentSnapshot){
      return documentSnapshot.data()!;
    });
  }
}

