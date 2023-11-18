import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Firebase/house_expenses.dart';


class DropExpenseTable extends StatelessWidget {
  final String houseId;

  const DropExpenseTable({super.key, required this.houseId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const [
                    TextSpan(
                        text: 'Are you sure to drop',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    TextSpan(
                        text: ' today\'s',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    TextSpan(text: ' expense table?')
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            TextButton(
              onPressed: () {
                HouseExpense().dropExpenseTable(houseId);
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
                        Icons.delete,
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
