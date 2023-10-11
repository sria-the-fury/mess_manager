import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Widgets/Extras/circular_profile.dart';
import 'package:mess_manager/Widgets/Extras/user_sign_provider.dart';
import 'package:mess_manager/Widgets/Extras/users_basic_data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool notificationSwitch = false;
  late String appTheme = 'LIGHT';

  @override
  Widget build(BuildContext context) {
    User? authUser = FirebaseAuth.instance.currentUser;
    debugPrint('${authUser}');

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
        title: const Text('PROFILE'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              CircularProfile(
                                  imageURL: authUser!.photoURL.toString(),
                                  imageHeight: 120),
                              Positioned(
                                  bottom: 0,
                                  right: 15,
                                  child: UserSignInProvider(
                                    providerId:
                                        authUser.providerData[0].providerId,
                                  ))
                            ],
                          ),
                          UserBasicData(authUser: authUser)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.teal[500],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.badge,
                                      color: Colors.white, size: 18),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Your profession',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.white54,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_city,
                                      color: Colors.white, size: 18),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('You home town',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(10)),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'User\'s Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.manage_accounts),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Update Profile',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            'Set Name, Phone, Date of Birth, etc',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_remove,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delete Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          Text(
                            'Deleting profile may lose all of your data',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.build),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'App Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(notificationSwitch == true
                              ? Icons.notifications_active
                              : Icons.notifications_off),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Notification',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                'Turn ${notificationSwitch == true ? 'off' : 'on'} Notification',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: notificationSwitch,
                        onChanged: (value) {
                          debugPrint('Switch $value');
                          setState(() {
                            notificationSwitch = value;
                          });
                        },
                        activeColor: Colors.teal[900],
                        inactiveThumbColor: Colors.black54,
                        inactiveTrackColor: Colors.white12,
                        trackOutlineWidth:
                            MaterialStateProperty.resolveWith((states) {
                          return 0;
                        }),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(appTheme == 'LIGHT'
                              ? Icons.light_mode
                              : appTheme == 'DARK' ? Icons.dark_mode: Icons.brightness_auto),
                          const SizedBox(
                            width: 5,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('App Theme',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                'Set as Dark, Light or System',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => setState(() {
                                appTheme = 'LIGHT';
                              }),
                              color: appTheme == 'LIGHT' ? Colors.teal[700] : Colors.grey,
                              icon: const Icon(Icons.light_mode)),
                          IconButton(
                              onPressed: () => setState(() {
                                appTheme = 'DARK';
                              }),
                              color: appTheme == 'DARK' ? Colors.teal[700] : Colors.grey,
                              icon: const Icon(Icons.dark_mode)),
                          IconButton(
                              onPressed: () => setState(() {
                                appTheme = 'SYSTEM';
                              }),
                              color: appTheme == 'SYSTEM' ? Colors.teal[700] : Colors.grey,
                              icon: const Icon(Icons.brightness_auto)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
