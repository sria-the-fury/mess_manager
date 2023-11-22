import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Methods/Firebase/house_meals.dart';

class UsersTodayMeals extends StatelessWidget {
   UsersTodayMeals({super.key});
  final FirestoreController userController = Get.put(FirestoreController());

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    User? currentUser = FirebaseAuth.instance.currentUser!;
    return Obx((){
      if(userController.houseTodayMeals.isEmpty){
        return const SizedBox();
      }
      else{
        final todayMeals = userController.houseTodayMeals;

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: darkTheme ? Colors.black87 : Colors.teal.shade100
          ),
          child:  Column(
            children: [
              const Text('YOUR MEALS FOR TODAY', style: TextStyle(fontSize: 16),),
              Text(DateFormat('E, dd MMM yyyy').format(DateTime.now())),
              const Divider(color: Colors.white54,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Column(
                        children: [
                          Icon(Icons.breakfast_dining),
                          Text('Breakfast')
                        ],
                      ),
                      IconButton(onPressed: todayMeals['breakfastTakenBy'].contains(currentUser.uid) ?
                          (){
                            HouseMeals().uncheckMeals(currentUser.uid, "BREAKFAST", todayMeals['id'],
                                userController.houseData['houseId']);
                          }
                          : () {
                        HouseMeals().checkMeals(currentUser.uid, "BREAKFAST", todayMeals['id'],
                            userController.houseData['houseId']);
                      },
                          icon:  Icon(todayMeals['breakfastTakenBy'].contains(currentUser.uid)
                              ? Icons.check_box : Icons.check_box_outline_blank)),
                    ],
                  ),
                  Column(
                    children: [
                      const Column(
                        children: [
                          Icon(Icons.lunch_dining),
                          Text('Lunch')
                        ],
                      ),
                      IconButton(onPressed: todayMeals['lunchTakenBy'].contains(currentUser.uid) ?
                          (){
                        HouseMeals().uncheckMeals(currentUser.uid, "LUNCH", todayMeals['id'],
                            userController.houseData['houseId']);
                      }
                          : () {
                        HouseMeals().checkMeals(currentUser.uid, "LUNCH", todayMeals['id'],
                            userController.houseData['houseId']);
                      },
                          icon:  Icon(todayMeals['lunchTakenBy'].contains(currentUser.uid)
                              ? Icons.check_box : Icons.check_box_outline_blank)),

                    ],
                  ),

                  Column(
                    children: [
                      const Column(
                        children: [
                          Icon(Icons.dinner_dining),
                          Text('Dinner')
                        ],
                      ),
                      IconButton(onPressed: todayMeals['dinnerTakenBy'].contains(currentUser.uid) ?
                          (){
                        HouseMeals().uncheckMeals(currentUser.uid, "DINNER", todayMeals['id'],
                            userController.houseData['houseId']);
                      }
                          : () {
                        HouseMeals().checkMeals(currentUser.uid, "DINNER", todayMeals['id'],
                            userController.houseData['houseId']);
                      },
                          icon:  Icon(todayMeals['dinnerTakenBy'].contains(currentUser.uid)
                              ? Icons.check_box : Icons.check_box_outline_blank)),


                    ],
                  ),
                ],
              )
            ],

          ),
        );
      }

    });
  }
}
