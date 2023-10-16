import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mess_manager/Widgets/Extras/circular_profile.dart';
import 'package:mess_manager/Widgets/Extras/user_sign_provider.dart';
import 'package:mess_manager/Widgets/Extras/users_basic_data.dart';
import 'package:mess_manager/Widgets/Route/update_user_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool notificationSwitch = GetStorage().read('switchNotification');
  late String appTheme = GetStorage().read('themeMode');

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    User? authUser = FirebaseAuth.instance.currentUser!;


    return Scaffold(
      appBar: AppBar(
        actions: [
          const Text('SIGNED IN WITH  ', style: TextStyle(fontSize: 16, color: Colors.white),),
          UserSignInProvider(
            providerId:
            authUser.providerData[0].providerId,
          )
        ],
        title: const Text('PROFILE'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                            const CircularProfile(
                                imageHeight: 120,
                              updatePhoto: true,
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
                                color: darkTheme ? Colors.black87 : Colors.teal[500],
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
                                    Text('Your home town',
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
                    color: darkTheme ? Colors.black87 : Colors.teal[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
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
                    InkWell(
                      onTap: () => Get.to(() => const UpdateUserProfile(),
                          transition: Transition.leftToRight),
                      child: Row(
                        children: [
                          const Icon(Icons.manage_accounts),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Update Profile',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                'Set Name, Phone, Date of Birth, etc',
                                style:
                                    TextStyle(fontSize: 12, color: darkTheme ? Colors.white54 : Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white54,
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () => FirebaseAuth.instance.signOut(),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Logout',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'You can login again.',
                                style:
                                TextStyle(fontSize: 12, color: darkTheme ? Colors.white54 : Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white54,
                      thickness: 1,
                    ),
                     Row(
                      children: [
                        const Icon(
                          Icons.person_remove,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Delete Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            Text(
                              'Deleting profile may lose all of your data',
                              style:
                                  TextStyle(fontSize: 12, color: darkTheme ? Colors.white54 : Colors.black54),
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
                    color: darkTheme ? Colors.black87 : Colors.teal[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.build, size:18),
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
                                  style: TextStyle(
                                      fontSize: 12, color: darkTheme ? Colors.white54 : Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Switch(
                          value: notificationSwitch,
                          onChanged: (value) {
                            GetStorage().write('switchNotification', value);
                            setState(() {
                              notificationSwitch = value;
                            });
                          },
                          activeColor: darkTheme ? Colors.white : Colors.teal[800],
                          activeTrackColor: darkTheme ? Colors.teal[500] : Colors.teal[300],
                          inactiveThumbColor: darkTheme ? Colors.white54 : Colors.black54,
                          inactiveTrackColor: darkTheme ? Colors.white12 : Colors.white54,
                          trackOutlineWidth:
                              MaterialStateProperty.resolveWith((states) {
                            return 0;
                          }),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.white54,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(appTheme == 'LIGHT'
                                ? Icons.light_mode
                                : appTheme == 'DARK'
                                    ? Icons.dark_mode
                                    : Icons.brightness_auto),
                            const SizedBox(
                              width: 5,
                            ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('App Theme',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  'Set as Dark, Light or System',
                                  style: TextStyle(
                                      fontSize: 12, color: darkTheme ? Colors.white54 : Colors.black54),
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
                                onPressed: () {
                                  if (darkTheme) {
                                    setState(() {
                                      appTheme = 'LIGHT';
                                    });
                                    GetStorage().write('themeMode', 'LIGHT');
                                    Get.changeThemeMode(ThemeMode.light);
                                  }
                                },
                                color: appTheme == 'LIGHT'
                                    ? Colors.teal[700]
                                    : Colors.grey,
                                icon: const Icon(Icons.light_mode)),
                            IconButton(
                                onPressed: () {
                                  if (!darkTheme) {
                                    setState(() {
                                      appTheme = 'DARK';
                                    });
                                    GetStorage().write('themeMode', 'DARK');
                                    Get.changeThemeMode(ThemeMode.dark);
                                  }
                                },
                                color: appTheme == 'DARK'
                                    ? Colors.teal[700]
                                    : Colors.grey,
                                icon: const Icon(Icons.dark_mode)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    appTheme = 'SYSTEM';
                                  });
                                  GetStorage().write('themeMode', 'SYSTEM');
                                  Get.changeThemeMode(ThemeMode.system);
                                },
                                color: appTheme == 'SYSTEM'
                                    ? Colors.teal[700]
                                    : Colors.grey,
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
      ),
    );
  }
}
