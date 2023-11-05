import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Methods/Firebase/add_house_to_db.dart';
import 'package:shimmer/shimmer.dart';

class SearchedUser {
  getSearchedUser(userEmail, houseId) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
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
                      height: 15,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.rectangle),
                    )),
              ],
            );
          }
          if (snapshot.hasData) {
            User? currentUser = FirebaseAuth.instance.currentUser!;
            final hasDocs = snapshot.data!.docs;
            if (hasDocs.isNotEmpty) {
              final searchedUser = snapshot.data!.docs[0].data();

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        child: CachedNetworkImage(
                          width: 30,
                          height: 30,
                          imageUrl: searchedUser['photoURL'],
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
                        '${searchedUser['displayName']}',)
                    ],
                  ),
                  if (searchedUser['userID'] != currentUser.uid &&
                      (!searchedUser.containsKey('houseId')))
                    IconButton(
                        onPressed: () {
                          AddHouseToDB().addMatesToHouse(houseId, searchedUser['userID']);
                        }, icon: const Icon(Icons.group_add))
                ],
              );
            }
            return const Text(
                'No user found. Please, write the correct email.');
          }
          return const Text('Something went wrong. Please, try again.');
        });
  }
}
