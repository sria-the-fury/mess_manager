import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Extras/verify_email.dart';
import 'package:mess_manager/Route/bottom_nav_home.dart';
import 'package:mess_manager/Route/login.dart';

class Authenticated extends StatelessWidget {
  const Authenticated({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        debugPrint('snapshot state => ${snapshot.connectionState}');
        if (snapshot.hasData) {
          debugPrint('authenticated SnapShot => ${snapshot.data}');
          if(snapshot.data!.emailVerified == false && snapshot.data!.providerData[0].providerId == 'password'){
            // snapshot.data!.sendEmailVerification();
            return const VerifyEmail();
          }

          // The user is logged in.
          return const BottomNavHome();
        }
        else {
          // The user is logged out.
          return const Login();
        }
      },
    );
  }
}
