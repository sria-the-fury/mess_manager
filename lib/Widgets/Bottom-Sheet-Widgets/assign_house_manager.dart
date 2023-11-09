import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Firebase/add_house_to_db.dart';

class AssignHouseManager extends StatelessWidget {
  final String houseMateName;
  final String houseMateId;
  final String houseId;
  const AssignHouseManager({super.key, required this.houseMateName,
    required this.houseMateId, required this.houseId});

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
                        text: 'Are you sure to assign ',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    TextSpan(
                        text: ' $houseMateName',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' as new house manager?')
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  AddHouseToDB().assignHouseManager(
                      houseId, houseMateId);
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
                          Icons.admin_panel_settings,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ASSIGN',
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
                      border: Border.all(color: Colors.teal.shade600,width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'REMAIN',)
                      ],
                    )),
              )
            ],)

        ],
      ),
    );
  }
}
