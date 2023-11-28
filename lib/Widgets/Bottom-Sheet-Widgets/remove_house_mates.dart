
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Firebase/add_house_to_db.dart';

class RemoveHouseMates extends StatelessWidget {
  final String houseMateName;
  final String houseMateId;
  final String houseId;
  final bool removeBySelf;

  const RemoveHouseMates({super.key, required this.houseMateName, required this.houseMateId, required this.houseId, required this.removeBySelf,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                        text: 'Are you sure to remove',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    TextSpan(
                        text: ' ${removeBySelf == true ? "yourself" : houseMateName}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' from this house? You can add him again.')
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            TextButton(
              onPressed: () {
                AddHouseToDB().removeMatesFromHouse(
                   houseMateId, houseId, removeBySelf);
                Get.back(closeOverlays: true);
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
                        'YES',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
            TextButton(
              onPressed: () {
              Get.back(closeOverlays: true);
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.teal[600],
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'REMAIN',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            )
          ],)

        ],
      ),
    );
  }
}
