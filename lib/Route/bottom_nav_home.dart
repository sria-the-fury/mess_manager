import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Extras/circular_profile.dart';
import 'package:mess_manager/Route/expenses.dart';
import 'package:mess_manager/Route/home.dart';
import 'package:mess_manager/Route/profile.dart';

class BottomNavHome extends StatefulWidget {
  const BottomNavHome({super.key});

  @override
  State<BottomNavHome> createState() => _HomeState();
}

class _HomeState extends State<BottomNavHome> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    User? authUser = FirebaseAuth.instance.currentUser;
    final showingPage = [
      const Home(),
      const Expenses(),
      const Profile(),
    ];

    final bottomNavItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Expenses'),
       BottomNavigationBarItem(icon: CircularProfile(imageURL: authUser!.photoURL.toString(),
         roundBorder: currentPageIndex == 2 ? true : false, imageHeight: 30, imageWidth: 30,) , label: 'Profile'),
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
