import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mess_manager/Widgets/Extras/circular_profile.dart';
import 'package:mess_manager/Widgets/Extras/user_sign_provider.dart';
import 'package:mess_manager/Widgets/Extras/users_basic_data.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool notificationSwitch = false;
  late String appTheme = GetStorage().read('themeMode');
  XFile? _pickedFile;
  late File displayImage;
  late double uploadProgress = 0;

  Future<void> _getPickedImage(context, authUser) async {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }

    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        compressQuality: 50,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'SET DISPlAY IMAGE',
              toolbarColor: darkTheme ? Colors.black : Colors.teal[600],
              statusBarColor: darkTheme ? Colors.black : Colors.teal[600],
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'SET DISPlAY IMAGE',
          ),
        ],
      );
      if (croppedFile != null) {
        debugPrint('cropped image => ${croppedFile.path}');
        try{
          await updateProfilePhoto(File(croppedFile.path));
          Get.snackbar('DISPLAY PHOTO', 'Your photo has been updated.',
              backgroundColor: Colors.teal.shade600.withOpacity(0.6),
              maxWidth: 300);
        } catch(error){
          Get.snackbar('ERROR @ SET PHOTO', '$error', snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromRGBO(255, 69, 0, 0.4), maxWidth: 300);
        }
      }
    }
  }

  updateProfilePhoto(image) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final storageRef = FirebaseStorage.instance.ref('displayPhoto/${currentUser.uid}.jpg');
    TaskSnapshot uploadTask = await storageRef.putFile(image);
      setState(() {
        uploadProgress = (uploadTask.bytesTransferred / uploadTask.totalBytes);
      });

    final downloadUrl = await storageRef.getDownloadURL();

    if (downloadUrl.isNotEmpty) {
      currentUser.updatePhotoURL(downloadUrl);
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
        'photoURL': downloadUrl,
      }, SetOptions(merge: true));
      setState(() {
        uploadProgress = 0;
      });
    }
  }

  Widget uploadProgressWidget (value) =>
      LinearProgressIndicator(value: value,color: Colors.teal[500],);



  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    User? authUser = FirebaseAuth.instance.currentUser!;
    debugPrint('uploadProgress => $uploadProgress');


    return Scaffold(
      bottomNavigationBar: uploadProgress != 0 ? uploadProgressWidget(uploadProgress) : null,
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
                                  imageURL: authUser.photoURL.toString(),
                                  imageHeight: 120),
                              Positioned(
                                right: 10,
                                  top: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(2),
                                    height: 28,
                                    width: 28,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                      onPressed: () => _getPickedImage(context,authUser),
                                      icon: Icon(Icons.add_a_photo, size: 20, color: Colors.teal[600],)
                                    ),
                                  ) ),
                              Positioned(
                                  bottom: 0,
                                  right: 50,
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
                  Row(
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
                  const Divider(
                    color: Colors.white,
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
                    color: Colors.white,
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
    );
  }
}
