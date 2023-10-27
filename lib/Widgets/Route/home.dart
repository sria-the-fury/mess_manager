import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Bottom-Modal-Widgets/add_house.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';
import 'package:mess_manager/Widgets/Extras/home_details.dart';

class Home extends StatelessWidget {
  final FirestoreController controller = Get.put(FirestoreController());
   Home({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    debugPrint('Data => ${controller.data}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body:  Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeDetails(),
            const Text('Wait and Send your email to to your mate\nor\nyou can create your house and add your mates.', textAlign:
            TextAlign.center,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate,
                  child:  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: 10,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.teal[500],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const AddHouse()
                    ],
                  ));
            },
          );

        },
        child: const Icon(Icons.house, color: Colors.white,),

      ),
    );
  }
}
