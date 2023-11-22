import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Extras/User-Widgets/user_preview_details.dart';
import 'package:shimmer/shimmer.dart';

class UserPreview extends StatelessWidget {
  final String? houseName;
  final String houseManager;
  final String houseId;
  final String memberId;
  UserPreview(
      {super.key,
       this.houseName,
      required this.houseManager,
      required this.houseId,
      required this.memberId});
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
        else {
          final selectedUser = userController.membersData
              .firstWhere((user) => (user['userID'] == memberId && user['houseId'] != null));
          return  GestureDetector(
                  onTap: houseName != null ? () => Get.defaultDialog(
                    title: '',
                    titlePadding: EdgeInsets.zero,
                    contentPadding: const EdgeInsets.only(top: 0),
                    titleStyle: const TextStyle(fontSize: 20),
                    content: UserPreviewDetails(
                        currentUserId: currentUser.uid,
                        houseManager: houseManager,
                        houseId: houseId,
                        selectedMembersData: selectedUser,
                        houseName: houseName!),
                  ) : null,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal[600],
                        shape: BoxShape.rectangle,
                        border: currentUser.uid == selectedUser['userID'] ? Border.all(color: Colors.white) : null,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          width: 30,
                          height: 30,
                          imageUrl: selectedUser['photoURL'],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: const ColorFilter.mode(
                                //     Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, imageData) =>
                                  CircularProgressIndicator(
                            strokeWidth: 2,
                            value: imageData.progress,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${getName(selectedUser['displayName'])}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        if (houseManager == selectedUser['userID'])
                          const Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.admin_panel_settings,
                                color: Colors.white,
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }
}
