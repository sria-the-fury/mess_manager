import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Extras/circular_profile.dart';
import 'package:transparent_image/transparent_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User? authUser = FirebaseAuth.instance.currentUser;
    debugPrint('{$authUser}');

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout)),],
        title: const Text('PROFILE'),
      ),
      body: Center(
        child: Column(
          children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    CircularProfile(imageURL: authUser!.photoURL.toString(), imageHeight: 120, imageWidth: 120),
                    Text(authUser.displayName.toString()),
                    Text(authUser.email.toString()),
                    Text('Verified: ${authUser.emailVerified.toString()}'),
                    IconButton(
                        onPressed: () async {
                          HttpsCallable madeAdmin =  FirebaseFunctions.instance.httpsCallable('addAdminRole');
                          await madeAdmin({"email": 'jakariamsria@gmail.com'});
                        },
                        icon: const Icon(Icons.admin_panel_settings, size: 50,))

                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
