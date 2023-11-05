import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';

import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/add_house.dart';
import 'package:mess_manager/Widgets/Custom-Bottom-Sheet/bottom_sheet.dart';
import 'package:mess_manager/Widgets/Extras/home_details.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  final FirestoreController userController = Get.put(FirestoreController());
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (userController.userData.isEmpty) {
                return const SizedBox();
              } else {
                if (userController.userData.containsKey('houseId')) {
                  return HomeDetails();
                } else if(!userController.userData.containsKey('houseId')){
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),

                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Shimmer.fromColors(
                            baseColor: darkTheme ? Colors.teal.shade50 : Colors.black,
                            highlightColor: Colors.teal.shade500,
                            child:  RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children:  [
                                  const TextSpan(text: 'Hello, ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  TextSpan(text: '${userController.userData['displayName']}.', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                          AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 3000),
                        animatedTexts: [
                          TyperAnimatedText('Welcome to Mess Manager. Please, add a house.'
                              ' After creating a house you can add your house mates.', speed: const Duration(milliseconds: 120)),
                        ]),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children:   const [
                                TextSpan(text: 'Or, ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              ],
                            ),
                          ),
                          Shimmer.fromColors(
                              baseColor: darkTheme ? Colors.teal.shade50 : Colors.black,
                              highlightColor: Colors.teal.shade500,
                              child: const Text('Wait for you house mate to let you in.'),
                          )
                        ],
                      ),

                    ),
                  );
                }
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (userController.userData.isEmpty) {
          return const SizedBox();
        } else {
          if (userController.userData.containsKey('houseId')) {
            return const SizedBox();
          }
          return FloatingActionButton(
            onPressed: () {
              CustomBottomSheet().showBottomSheet(context, const AddHouse());
            },
            child: const Icon(
              Icons.add_home_sharp,
              color: Colors.white,
            ),
          );
        }
      }),
    );
  }
}
