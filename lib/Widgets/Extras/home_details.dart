import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:intl/intl.dart';
import 'package:mess_manager/Widgets/Extras/User-Widgets/user_preview.dart';
import 'package:shimmer/shimmer.dart';
class HomeDetails extends StatelessWidget {
  final FirestoreController houseController = Get.put(FirestoreController());

  HomeDetails({super.key});
  getCreatedTime(time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
      time.seconds * 1000,
    );

    return DateFormat.yMMMEd().add_jms().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    return Obx(() {
      if (houseController.houseData.isEmpty) {
        return Center(
          child: Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: darkTheme ? Colors.black87 : Colors.teal[100]
              ),
              child: Column(
                children: [
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade500,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 20,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            shape: BoxShape.rectangle),
                      )),
                  const SizedBox(height: 5,),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade500,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            shape: BoxShape.rectangle),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 20,),
                          const SizedBox(width: 5,),
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade500,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 15,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    shape: BoxShape.rectangle),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.group, size: 20,),
                          const SizedBox(width: 5,),
                          Expanded(child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              Container(
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
                              ),
                              Container(
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
                              ),
                              Container(
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
                              ),
                              Container(
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
                              ),
                              Container(
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
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              )
          ),
        );
      } else {
        return Container(
          clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: darkTheme ? Colors.black87 : Colors.teal[100]
            ),
            child: Column(
              children: [
                Text('${houseController.houseData['houseName']}', textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),),
                Text(getCreatedTime(houseController.houseData['createdAt']), style: const TextStyle(fontSize: 11),),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 25,),
                        const SizedBox(width: 5,),
                        Expanded(
                            child: Text('${houseController.houseData['houseLocation']}',
                              style: const TextStyle(fontSize: 16), overflow: TextOverflow.clip,)),
                      ],
                    ),
                     Row(
                      children: [
                        Stack(
                          children: [
                            const Icon(Icons.group, size: 25,),
                            Positioned(
                              top:-1,
                              right: -1,
                                child: Badge(label:Text(houseController.houseData['members'].length.toString()),
                                  backgroundColor: Colors.teal[600], textColor: Colors.white, textStyle: const TextStyle(fontSize: 10),)),
                          ],
                        ),

                        const SizedBox(width: 5,),
                        Expanded(child: Wrap(
                          spacing: 5,
                          children: houseController.houseData['members'].map<Widget>((memberId) {
                            final membersList  = houseController.houseData['members'];
                            final lastMember =  membersList[membersList.length - 1];
                            final currentMember = membersList.indexOf(memberId);

                              return UserPreview(memberId: memberId, houseName: houseController.houseData['houseName'], currentMemberIndex: currentMember,);}).toList(),
                        )),
                      ],
                    ),

                  ],
                ),
              ],
            )
        );
      }
    },);
  }
}