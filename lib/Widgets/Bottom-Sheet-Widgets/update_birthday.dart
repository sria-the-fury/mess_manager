import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mess_manager/Methods/Firebase/initial_profile_update.dart';

class UpdateBirthday extends StatefulWidget {
  const UpdateBirthday({super.key});

  @override
  State<UpdateBirthday> createState() => _UpdateBirthdayState();
}

class _UpdateBirthdayState extends State<UpdateBirthday> {
  DateTime _date = DateTime.now();
  late bool showDate = false;


  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year.toInt() - 9),
      firstDate: DateTime(1980),
      lastDate: DateTime(DateTime.now().year.toInt() - 9),
      helpText: 'Select Your Date of Birth',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        showDate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme =
    Theme.of(context).brightness.name == 'dark' ? true : false;
    User? authUser = FirebaseAuth.instance.currentUser!;

    return Container(
      padding: const EdgeInsets.all(10),
      child:  Column(

        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration:  BoxDecoration(
              color: darkTheme ? Colors.black87 : Colors.teal.shade100,
              borderRadius: BorderRadius.circular(25)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                  children: [
                    const Icon(Icons.cake),
                    const SizedBox(width: 10,),
                     Text(showDate != true ? 'Your Birthday Date' : DateFormat('dd MMMM yyyy').format(_date))
                  ],
                ),
                IconButton(onPressed: (){
                  _selectDate();
                },
                    icon: const Icon(Icons.calendar_month))

              ],
            ),
          ),
          const SizedBox(height: 5,),
          const Text('you can set your date of birth only once.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: showDate == true ? () {
                  InitialProfileUpdate().updateDateOfBirth(authUser.uid, _date);
                  Get.back(closeOverlays: true);
                } : null ,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade600,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cake,
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
                        border: Border.all(color: darkTheme ? Colors.white : Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cancel,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CLOSE',
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
