import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:intl/intl.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/add_house.dart';
import 'package:mess_manager/Widgets/Custom-Bottom-Sheet/bottom_sheet.dart';
import 'package:mess_manager/Widgets/Extras/User-Widgets/user_preview.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/add_house_mates.dart';
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
    final darkTheme =
        Theme.of(context).brightness.name == 'dark' ? true : false;
    return Obx(
      () {
        if (houseController.houseData.isEmpty) {
          return Center(
            child: Container(
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: darkTheme ? Colors.black87 : Colors.teal[100]),
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
                    const SizedBox(
                      height: 5,
                    ),
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
                            const Icon(
                              Icons.location_on,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.group,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Shimmer.fromColors(
                                    baseColor: Colors.grey.shade500,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: 15,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          shape: BoxShape.rectangle),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Wrap(
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
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
                                                color: Colors.white
                                                    .withOpacity(0.4),
                                                shape: BoxShape.rectangle),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          );
        } else {
          return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: darkTheme ? Colors.black87 : Colors.teal[100]),
              child: Column(
                children: [
                  Text(
                    '${houseController.houseData['houseName']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    getCreatedTime(houseController.houseData['createdAt']),
                    style: const TextStyle(fontSize: 11),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            '${houseController.houseData['houseLocation']}',
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.clip,
                          )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.group,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(houseController
                                              .houseData['members'].length >
                                          1 &&
                                      houseController
                                              .houseData['members'].length <
                                          3
                                  ? 'You & ${houseController.houseData['members'].length - 1} other'
                                  : houseController
                                              .houseData['members'].length >
                                          2
                                      ? 'You & ${houseController.houseData['members'].length - 1} others'
                                      : 'Only you'),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: houseController.houseData['members']
                                .map<Widget>((memberId) {

                              return UserPreview(
                                  houseName: houseController
                                      .houseData['houseName'],
                                  memberId: memberId,
                                  houseId:
                                      houseController.houseData['houseId'],
                                  houseCreator: houseController
                                      .houseData['createdBy'],
                                  houseManager: houseController
                                      .houseData['houseManager']);
                            }).toList(),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: IconButton(
                                    onPressed: () {
                                      CustomBottomSheet()
                                          .showBottomSheet(context,
                                          AddHouse(isEdit: true,
                                          houseName: houseController.houseData['houseName'],
                                          houseId: houseController.houseData['houseId'],
                                          houseAddress: houseController.houseData['houseLocation']));
                                    },
                                    style: IconButton.styleFrom(
                                        backgroundColor: darkTheme
                                            ? Colors.black87
                                            : Colors.teal.shade600,
                                        side: const BorderSide(
                                            color: Colors.white, width: 2)),
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  )),
                              SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: IconButton(
                                    onPressed: () {
                                      CustomBottomSheet().showBottomSheet(
                                          context,
                                          AddHouseMates(
                                              houseId:
                                              houseController.houseData['houseId']));
                                    },
                                    style: IconButton.styleFrom(
                                        backgroundColor: Colors.teal.shade600,
                                        side: const BorderSide(
                                            color: Colors.white, width: 2)),
                                    icon: const Icon(
                                      Icons.person_add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ))

                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ));
        }
      },
    );
  }
}
