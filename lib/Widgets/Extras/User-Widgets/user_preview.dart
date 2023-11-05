import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPreview extends StatelessWidget {
  final String memberId;
  final int currentMemberIndex;
  final String houseName;
   UserPreview(
      {super.key, required this.memberId, required this.houseName, required this.currentMemberIndex});
  final FirestoreController userController = Get.put(FirestoreController());

  getName(name) {
    List<String> nameList = name.split(" ");
    return nameList[0];
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser!;
    return  Obx((){
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
        return GestureDetector(
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
                    imageUrl: userController.membersData[currentMemberIndex]['photoURL'],
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
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () async {
                            final Uri url = Uri.parse('tel:+8801571734206');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          }, icon: const Icon(Icons.call)),
                      IconButton(
                          onPressed: () async {
                            final Uri url = Uri.parse('https://wa.me/8801571734206');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.whatsapp)),
                      IconButton(
                          onPressed: () {},
                          icon:
                              const FaIcon(FontAwesomeIcons.facebookMessenger)),
                    ],
                  )
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
                    imageUrl: userController.membersData[currentMemberIndex]['photoURL'],
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
                  '${getName(userController.membersData[currentMemberIndex]['displayName'])}${memberId == currentUser.uid ? ' (You)' : ''}',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
