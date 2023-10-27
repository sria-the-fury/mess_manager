import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:intl/intl.dart';
import 'package:mess_manager/Widgets/Extras/User-Widgets/user_preview.dart';
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
      if (houseController.data.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
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
                Text('${houseController.data[0]['houseName']}', textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),),
                Text(getCreatedTime(houseController.data[0]['createdAt']), style: const TextStyle(fontSize: 11),),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 20,),
                        const SizedBox(width: 5,),
                        Expanded(
                            child: Text('${houseController.data[0]['houseLocation']}',
                              style: const TextStyle(fontSize: 16), overflow: TextOverflow.clip,)),
                      ],
                    ),
                     Row(
                      children: [
                        const Icon(Icons.group, size: 20,),
                        const SizedBox(width: 5,),
                        Expanded(child: Wrap(
                          spacing: 5,
                          children: houseController.data[0]['members'].map<Widget>((memberId) =>
                              UserPreview(memberId: memberId, houseName: houseController.data[0]['houseName'],)).toList(),
                        )),
                        // if(houseController.data[0]['members'].length == 1 ) const Text('Only you', style: TextStyle(fontSize: 16),),
                        // if(houseController.data[0]['members'].length > 1 ) Text('You & ${houseController.data[0]['members'].length -1} more '
                        //     '${houseController.data[0]['members'].length -1 > 1 ? 'people' : 'person'}',
                        //   style: const TextStyle(fontSize: 16),),
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
