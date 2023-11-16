import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/update_contact.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/update_profession_hometown.dart';
import 'package:mess_manager/Widgets/Custom-Bottom-Sheet/bottom_sheet.dart';
import 'package:mess_manager/Widgets/Extras/circular_profile.dart';
import 'package:mess_manager/Widgets/Extras/user_sign_provider.dart';
import 'package:mess_manager/Widgets/Extras/users_basic_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool notificationSwitch = GetStorage().read('switchNotification');
  late String appTheme = GetStorage().read('themeMode');
  final FirestoreController userController = Get.put(FirestoreController());

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
                            Obx((){
                              if(userController.userData.isEmpty){
                                return const SizedBox();
                              }
                              return UserBasicData(authUser: authUser, userData: userController.userData);
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Obx((){
                          if(userController.userData.isEmpty){
                            return const SizedBox();
                          }
                          else{
                            final contactNo =  userController.userData['phoneNumber'];
                            final messengerLink =  userController.userData['messengerLink'];
                            final whatsappNumber =  userController.userData['whatsappNumber'];
                            return GestureDetector(
                              onTap: () {
                                if(contactNo == null && messengerLink == null && whatsappNumber == null){
                                  CustomBottomSheet().showBottomSheet(context, UpdateContact(userId: authUser.uid,));
                                } else{
                                  CustomBottomSheet()
                                      .showBottomSheet(context,
                                      UpdateContact(userId: authUser.uid, isEdit: true,
                                        phoneNumber: contactNo,
                                      messengerLink: messengerLink,
                                      whatsappNumber: whatsappNumber,));
                                }

                                },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: contactNo != null ? () async {
                                          final Uri url =
                                          Uri.parse('tel:+88$contactNo');
                                          if (!await launchUrl(url)) {
                                            throw Exception('Could not launch $url');
                                          }
                                        } : null ,
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.call)),
                                    IconButton(
                                        onPressed: messengerLink != null ? () async {
                                          final Uri url =
                                          Uri.parse('$messengerLink');
                                          if (!await launchUrl(url)) {
                                            throw Exception('Could not launch $url');
                                          }
                                        } : null,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.facebookMessenger)),
                                    IconButton(
                                        onPressed: whatsappNumber != null ? () async {
                                          final Uri url =
                                          Uri.parse('https://wa.me/88$whatsappNumber');
                                          if (!await launchUrl(url)) {
                                            throw Exception('Could not launch $url');
                                          }
                                        } : null ,
                                        padding: EdgeInsets.zero,
                                        icon: const FaIcon(FontAwesomeIcons.whatsapp)),
                                  ],
                                ),
                              ),
                            );
                          }

                        }),

                        const SizedBox(
                          height: 10,
                        ),
                        Obx((){
                          if(userController.userData.isEmpty){
                            return const SizedBox();

                          }
                          else{
                            final userRole =  userController.userData['role'];
                            final userWorkPlace =  userController.userData['orgName'];
                            final homeTown =  userController.userData['homeTown'];
                            return GestureDetector(
                              onTap: (){
                                if(userRole == null && homeTown == null && userWorkPlace ==  null){
                                  CustomBottomSheet().showBottomSheet(context,
                                      UpdateProfessionHometown(userId: authUser.uid));
                                } else{
                                  CustomBottomSheet().showBottomSheet(context,
                                      UpdateProfessionHometown(userId: authUser.uid,
                                      isEdit: true,
                                        role: userRole,
                                        orgName: userWorkPlace,
                                        homeTown: homeTown,
                                      ));
                                }

                              },
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: darkTheme ? Colors.black87 : Colors.teal[500],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15)),
                                  child:  Column(
                                    children: [
                                      Row(
                                        children: [
                                           Icon(Icons.badge,
                                              color: userRole != null && userWorkPlace != null
                                                  ? Colors.white :  Colors.grey.shade600, size: 18),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(userRole != null && userWorkPlace != null
                                                ? "$userRole @ $userWorkPlace" : 'Your profession',
                                                style:  TextStyle(
                                                    color: userRole != null && userWorkPlace != null
                                                        ? Colors.white :  Colors.grey.shade600, fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.white54,
                                      ),
                                       Row(
                                        children: [
                                           Icon(Icons.location_city,
                                              color: homeTown != null
                                                  ? Colors.white :  Colors.grey.shade600, size: 18),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(child: Text(homeTown != null ? '$homeTown' : 'Your home town',
                                              style: TextStyle(
                                                  color: homeTown != null
                                                      ? Colors.white :  Colors.grey.shade600, fontSize: 15)),)

                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }

                        })

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
                    const Divider(
                      color: Colors.white54,
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Get.delete<FirestoreController>();
                        FirebaseAuth.instance.signOut();
                      },
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
