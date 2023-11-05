import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Methods/Firebase/add_house_to_db.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPreview extends StatelessWidget {
  final int currentMemberIndex;
  final String houseName;
  final String houseManager;
  final String houseCreator;
  final String houseId;
  UserPreview(
      {super.key,
      required this.houseName,
      required this.currentMemberIndex,
      required this.houseManager,
      required this.houseCreator,
      required this.houseId});
  final FirestoreController userController = Get.put(FirestoreController());

  getName(name) {
    List<String> nameList = name.split(" ");
    return nameList[0];
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser!;

    return Obx(
      () {
        if (userController.membersData.isEmpty) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.teal[600],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 10,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.rectangle),
                    )),
              ],
            ),
          );
        }

        return userController.membersData[currentMemberIndex]
                .containsKey('houseId')
            ? GestureDetector(
                onTap: () => Get.defaultDialog(
                  title: '',
                  titlePadding: EdgeInsets.zero,
                  contentPadding: const EdgeInsets.only(top: 0),
                  titleStyle: const TextStyle(fontSize: 20),
                  content: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          width: 100,
                          height: 100,
                          imageUrl: userController
                              .membersData[currentMemberIndex]['photoURL'],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: const ColorFilter.mode(
                                //     Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, imageData) =>
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            value: imageData.progress,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 100,
                          ),
                        ),
                        Text(
                          '${userController.membersData[currentMemberIndex]['displayName']}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                              const TextSpan(
                                  text: 'Member of',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                              TextSpan(
                                  text: ' $houseName',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final Uri url =
                                      Uri.parse('tel:+8801571734206');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                icon: const Icon(Icons.call)),
                            IconButton(
                                onPressed: () async {
                                  final Uri url =
                                      Uri.parse('https://wa.me/8801571734206');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                icon: const FaIcon(FontAwesomeIcons.whatsapp)),
                            IconButton(
                                onPressed: () async {
                                  final Uri url =
                                      Uri.parse('https://m.me/tanik.anas');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                icon: const FaIcon(
                                    FontAwesomeIcons.facebookMessenger)),
                          ],
                        ),
                        if (currentUser.uid == houseManager &&
                            houseManager !=
                                userController.membersData[currentMemberIndex]
                                    ['userID'] &&
                            houseCreator !=
                                userController.membersData[currentMemberIndex]
                                    ['userID'])
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  AddHouseToDB().removeMatesFromHouse(
                                      userController
                                              .membersData[currentMemberIndex]
                                          ['userID'],
                                      houseId);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.person_remove,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'REMOVE',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )),
                              ),
                              TextButton(
                                onPressed: () {
                                  AddHouseToDB().changeHouseManager(
                                      houseId,
                                      userController
                                              .membersData[currentMemberIndex]
                                          ['userID']);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.teal[600],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'MANAGER',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        if (currentUser.uid ==
                                userController.membersData[currentMemberIndex]
                                    ['userID'] &&
                            houseCreator != currentUser.uid &&
                            currentUser.uid != houseManager)
                          TextButton(
                            onPressed: () {},
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.arrowRightFromBracket,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'LEAVE $houseName',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                )),
                          ),
                      ],
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal[600],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        child: CachedNetworkImage(
                          width: 30,
                          height: 30,
                          imageUrl: userController
                              .membersData[currentMemberIndex]['photoURL'],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: const ColorFilter.mode(
                                //     Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, imageData) =>
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            value: imageData.progress,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${getName(userController.membersData[currentMemberIndex]['displayName'])}'
                        '${userController.membersData[currentMemberIndex]['userID'] == currentUser.uid ? ' (u)' : ''}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
