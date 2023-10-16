import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Widgets/Extras/users_basic_data_widget.dart';

class UserBasicData extends StatelessWidget {
  final User authUser;
  const UserBasicData({super.key, required this.authUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UsersBasicDataWidget(userData: authUser.displayName.toString(), iconName: Icons.person,
            fontWeight: FontWeight.bold,),
          UsersBasicDataWidget(userData: authUser.email.toString(), iconName: Icons.email),
          const UsersBasicDataWidget(userData: 'Date of Birth', iconName: Icons.cake),
          const UsersBasicDataWidget(userData: 'Phone Number', iconName: Icons.call),
        ],
      ),
    );
  }
}
