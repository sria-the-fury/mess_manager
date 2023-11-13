import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Extras/circular_profile.dart';
import 'package:mess_manager/Widgets/Route/expenses.dart';
import 'package:mess_manager/Widgets/Route/home.dart';
import 'package:mess_manager/Widgets/Route/meals.dart';
import 'package:mess_manager/Widgets/Route/profile.dart';

class BottomNavHome extends StatefulWidget {
  const BottomNavHome({super.key});

  @override
  State<BottomNavHome> createState() => _HomeState();
}

class _HomeState extends State<BottomNavHome> {
  int currentPageIndex = 0;



  @override
  void initState() {
    if(GetStorage().read('switchNotification') == null){
      GetStorage().write('switchNotification', true);
    }
    Get.put(()=>FirestoreController().onInit());
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    Get.put(()=>FirestoreController().onClose());

  }

  @override
  Widget build(BuildContext context) {

    final showingPage = [
       Home(),
      const Meals(),
      Expenses(),
      const Profile(),
    ];

    final bottomNavItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.flatware), label: 'Meals'),
      const BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Expenses'),
       BottomNavigationBarItem(icon: CircularProfile(roundBorder: currentPageIndex == 3
           ? true : false, imageHeight: 30) , label: 'Profile'),
    ];

    final bottomNavBar = BottomNavigationBar(
      items: bottomNavItems,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentPageIndex,
      enableFeedback: true,
      onTap: (int index){
      setState(() {
        currentPageIndex = index;
      });
      },
    );

    return Scaffold(
      body: showingPage[currentPageIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
