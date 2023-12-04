import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/add_house.dart';
import 'package:mess_manager/Widgets/Custom-Bottom-Sheet/bottom_sheet.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';
import 'package:mess_manager/Widgets/Extras/home_details.dart';
import 'package:mess_manager/Widgets/Extras/users_today_meals.dart';
import 'package:share_plus/share_plus.dart';
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
      body: Obx(() {
        if (userController.userData.isEmpty) {
          return const SizedBox();
        } else {
          if (userController.userData.containsKey('houseId')) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeDetails(),
                  UsersTodayMeals()
                ],
              ),
            );
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
                        ' After creating a house, you can add your house mates.', speed: const Duration(milliseconds: 120)),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Share you email'),
                        const SizedBox(width: 5,),
                        IconButton(onPressed: () async {
                          final shareResult =
                          await Share.shareWithResult("Hey, Please add  me to a house in the Mess Manager. Thank you.\n\nHere is my email: ${userController.userData['email']}");
                          if(shareResult.status == ShareResultStatus.success){
                            CustomGetSnackbar().success('SHARE', 'You have shared your email.');
                          }
                        },
                            icon: const Icon(Icons.send))
                      ],
                    )
                  ],
                ),

              ),
            );
          }
          return const SizedBox();
        }
      }),
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
