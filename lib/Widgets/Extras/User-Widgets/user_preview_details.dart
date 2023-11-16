import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/assign_house_manager.dart';
import 'package:mess_manager/Widgets/Bottom-Sheet-Widgets/remove_house_mates.dart';
import 'package:mess_manager/Widgets/Custom-Bottom-Sheet/bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPreviewDetails extends StatelessWidget {
  final Map selectedMembersData;
  final String currentUserId;
  final String houseManager;
  final String houseId;
  final String houseName;
  const UserPreviewDetails({super.key,
    required this.currentUserId,
    required this.houseManager, required this.houseId,
    required this.selectedMembersData, required this.houseName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            width: 100,
            height: 100,
            imageUrl: selectedMembersData['photoURL'],
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  // colorFilter: const ColorFilter.mode(
                  //     Colors.red, BlendMode.colorBurn)
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, imageData) =>
                CircularProgressIndicator(
                  strokeWidth: 2,
                  value: imageData.progress,
                ),
            errorWidget: (context, url, error) => const Icon(
              Icons.account_circle,
              size: 100,
            ),
          ),
          Text(
            '${selectedMembersData['displayName']}',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if(houseManager == selectedMembersData['userID'])
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.admin_panel_settings),
                SizedBox(width: 5,),
                Text('House Manager', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            ),
          RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                        text: 'Member of',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    TextSpan(
                        text: ' $houseName',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ])),
          if(currentUserId != selectedMembersData['userID'])Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: selectedMembersData['phoneNumber'] != null ? () async {
                    final Uri url =
                    Uri.parse('tel:+88${selectedMembersData['phoneNumber']}');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  } : null,
                  icon: const Icon(Icons.call)),
              IconButton(
                  onPressed: selectedMembersData['messengerLink'] != null ? () async {
                    final Uri url =
                    Uri.parse('${selectedMembersData['messengerLink']}');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  } : null,
                  icon: const FaIcon(
                      FontAwesomeIcons.facebookMessenger)),
              IconButton(
                  onPressed: selectedMembersData['whatsappNumber'] != null ?  () async {
                    final Uri url =
                    Uri.parse('https://wa.me/88${selectedMembersData['whatsappNumber']}');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  } : null,
                  icon: const FaIcon(FontAwesomeIcons.whatsapp)),
            ],
          ),
          if (currentUserId == houseManager &&
              houseManager != selectedMembersData['userID'])
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    CustomBottomSheet().showBottomSheet(context,
                        RemoveHouseMates(houseMateName: selectedMembersData['displayName'],
                          houseMateId: selectedMembersData['userID'], houseId: houseId,

                        ));
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
                            'REMOVE',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ),
                TextButton(
                  onPressed: () {
                    CustomBottomSheet().showBottomSheet(context,
                        AssignHouseManager(houseMateName: selectedMembersData['displayName'],
                            houseMateId: selectedMembersData['userID'],
                            houseId: houseId));
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
                            'MANAGER',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                )
              ],
            ),
          if (currentUserId ==
              selectedMembersData['userID'] &&
             currentUserId != houseManager)
            TextButton(
              onPressed: () {},
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'LEAVE',
                        style:
                        TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
