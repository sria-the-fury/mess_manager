import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Extras/add_shopping_items.dart';

class Expenses extends StatelessWidget {
  final FirestoreController houseController = Get.put(FirestoreController());
  Expenses({super.key});

  @override
  Widget build(BuildContext context) {

    User? currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('EXPENSES'),
      ),
      body: const Center(
        child: Text('Expenses'),
      ),
      floatingActionButton: Obx((){
        if(houseController.houseData.isNotEmpty){
          if(houseController.houseData['houseManager'] == currentUser.uid){
            return FloatingActionButton(onPressed: (){
              Get.to( () => AddShoppingItems(houseId: houseController.houseData['houseId'], currentUserId: currentUser.uid),
                  transition: Transition.downToUp);
            },
                child: const Icon(Icons.shopping_bag, color: Colors.white,));
          }
          return const SizedBox();
        }
        return const SizedBox();
      })
    );
  }
}
