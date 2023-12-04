import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Widgets/Extras/monthly-meals/monthly_meals.dart';
import 'package:mess_manager/Widgets/Extras/today_meals.dart';

class Meals extends StatelessWidget {
  const Meals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> const MonthlyMeals());
          }
              , icon: const Icon(Icons.calendar_view_month))
        ],
        title: const Text('MEALS'),
      ),
      body:  SingleChildScrollView(
        child: TodayMeals(),
      ),
    );
  }
}
