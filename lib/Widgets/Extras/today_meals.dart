import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'User-Widgets/user_preview.dart';

class TodayMeals extends StatelessWidget {
  TodayMeals({super.key});
  final FirestoreController houseController = Get.put(FirestoreController());

  @override
  Widget build(BuildContext context) {
    final darkTheme =
        Theme.of(context).brightness.name == 'dark' ? true : false;
    return Obx(() {
      if (houseController.houseTodayMeals.isEmpty) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.breakfast_dining),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Breakfast',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.restaurant),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 9),
                              label: Text('100'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Wrap(
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              shape: BoxShape.rectangle),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.no_meals),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 9),
                              label: Text('100'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Wrap(
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              shape: BoxShape.rectangle),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.lunch_dining),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Lunch',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.restaurant),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 9),
                              label: Text('100'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Wrap(
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              shape: BoxShape.rectangle),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.no_meals),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 9),
                              label: Text('100'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Wrap(
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              shape: BoxShape.rectangle),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.dinner_dining),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Dinner',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.restaurant),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 9),
                              label: Text('100'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Wrap(
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              shape: BoxShape.rectangle),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.no_meals),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 9),
                              label: Text('100'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Wrap(
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
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
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              shape: BoxShape.rectangle),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        final todayMeals = houseController.houseTodayMeals;

        return Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.breakfast_dining),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Breakfast',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                         Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.restaurant),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 9),
                              label: Text('${todayMeals['breakfastTakenBy'].isNotEmpty ? todayMeals['breakfastTakenBy'].length : '0'}'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: todayMeals['breakfastTakenBy'].isNotEmpty
                              ? Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: todayMeals['breakfastTakenBy']
                                      .map<Widget>((memberId) {
                                    return UserPreview(
                                        memberId: memberId,
                                        houseId: houseController
                                            .houseData['houseId'],
                                        houseManager: houseController
                                            .houseData['houseManager']);
                                  }).toList(),
                                )
                              : const Text('No one takes breakfast.'),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                         Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.no_meals),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 9),
                              label: Text('${todayMeals['breakfastNotTakenBy'].isNotEmpty ? todayMeals['breakfastNotTakenBy'].length : '0'}'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: todayMeals['breakfastNotTakenBy'].isNotEmpty
                              ? Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: todayMeals['breakfastNotTakenBy']
                                      .map<Widget>((memberId) {
                                    return UserPreview(
                                        memberId: memberId,
                                        houseId: houseController
                                            .houseData['houseId'],
                                        houseManager: houseController
                                            .houseData['houseManager']);
                                  }).toList(),
                                )
                              : const Text('Everyone takes breakfast.'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.lunch_dining),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Lunch',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                         Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.restaurant),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 9),
                              label: Text('${todayMeals['lunchTakenBy'].isNotEmpty ? todayMeals['lunchTakenBy'].length : '0'}'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: todayMeals['lunchTakenBy'].isNotEmpty
                              ? Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: todayMeals['lunchTakenBy']
                                .map<Widget>((memberId) {
                              return UserPreview(
                                  memberId: memberId,
                                  houseId: houseController
                                      .houseData['houseId'],
                                  houseManager: houseController
                                      .houseData['houseManager']);
                            }).toList(),
                          )
                              : const Text('No one takes lunch.'),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                         Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.no_meals),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 9),
                              label: Text('${todayMeals['lunchNotTakenBy'].isNotEmpty ? todayMeals['lunchNotTakenBy'].length : '0'}'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: todayMeals['lunchNotTakenBy'].isNotEmpty
                              ? Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: todayMeals['lunchNotTakenBy']
                                .map<Widget>((memberId) {
                              return UserPreview(
                                  memberId: memberId,
                                  houseId: houseController
                                      .houseData['houseId'],
                                  houseManager: houseController
                                      .houseData['houseManager']);
                            }).toList(),
                          )
                              : const Text('Everyone takes lunch.'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.dinner_dining),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Dinner',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                         Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.restaurant),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 9),
                              label: Text('${todayMeals['dinnerTakenBy'].isNotEmpty ? todayMeals['dinnerTakenBy'].length : '0'}'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: todayMeals['dinnerTakenBy'].isNotEmpty
                              ? Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: todayMeals['dinnerTakenBy']
                                .map<Widget>((memberId) {
                              return UserPreview(
                                  memberId: memberId,
                                  houseId: houseController
                                      .houseData['houseId'],
                                  houseManager: houseController
                                      .houseData['houseManager']);
                            }).toList(),
                          )
                              : const Text('No one takes dinner.'),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.no_meals),
                            Badge(
                              smallSize: 20,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 9),
                              label: Text('${todayMeals['dinnerNotTakenBy'].isNotEmpty ? todayMeals['dinnerNotTakenBy'].length : '0'}'),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: todayMeals['dinnerNotTakenBy'].isNotEmpty
                              ? Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: todayMeals['dinnerNotTakenBy']
                                .map<Widget>((memberId) {
                              return UserPreview(
                                  memberId: memberId,
                                  houseId: houseController
                                      .houseData['houseId'],
                                  houseManager: houseController
                                      .houseData['houseManager']);
                            }).toList(),
                          )
                              : const Text('Everyone takes dinner.'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
