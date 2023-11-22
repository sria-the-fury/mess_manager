import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';

class HouseMeals{

  checkMeals(userId, mealsName, mealsId, houseId) async{
    getMealsName(){
      if(mealsName == "LUNCH"){
        return "lunchTakenBy";
      } else if(mealsName == "DINNER"){
        return "dinnerTakenBy";
      }
      return "breakfastTakenBy";
    }

    notTakenMealsName(){
      if(mealsName == "LUNCH"){
        return "lunchNotTakenBy";
      } else if(mealsName == "DINNER"){
        return "dinnerNotTakenBy";
      }
      return "breakfastNotTakenBy";
    }
    await FirebaseFirestore.instance.collection('houses').doc(houseId).collection('meals')
        .doc(mealsId).set({
         getMealsName(): FieldValue.arrayUnion([userId]),
      notTakenMealsName(): FieldValue.arrayRemove([userId])

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().success('MEALS', 'Your ${mealsName.toLowerCase()} meal has been checked.');
    });
  }
  uncheckMeals(userId, mealsName, mealsId, houseId) async{
    getMealsName(){
      if(mealsName == "LUNCH"){
        return "lunchTakenBy";
      } else if(mealsName == "DINNER"){
        return "dinnerTakenBy";
      }
      return "breakfastTakenBy";
    }

    notTakenMealsName(){
      if(mealsName == "LUNCH"){
        return "lunchNotTakenBy";
      } else if(mealsName == "DINNER"){
        return "dinnerNotTakenBy";
      }
      return "breakfastNotTakenBy";
    }
    await FirebaseFirestore.instance.collection('houses').doc(houseId).collection('meals')
        .doc(mealsId).set({
      getMealsName(): FieldValue.arrayRemove([userId]),
      notTakenMealsName(): FieldValue.arrayUnion([userId])

    }, SetOptions(merge: true)).then((value){
      Get.back(closeOverlays: true);
      CustomGetSnackbar().warning('MEALS', 'You ${mealsName.toLowerCase()} meal has been unchecked.');
    });
  }
}