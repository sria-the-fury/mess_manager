import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_manager/Widgets/Extras/users_basic_data_widget.dart';

class UserBasicData extends StatelessWidget {
  final User authUser;
  final Map<String, dynamic> userData;
  const UserBasicData({super.key, required this.authUser, required this.userData});

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

          userData['birthday'] != null ?
          const UsersBasicDataWidget(userData: 'Date of Birth', iconName: Icons.cake)
              :  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon( Icons.cake, size: 18, color: Colors.grey.shade600,),
              const SizedBox(
                width: 5,
              ),
              Text('Date of Birth', style: TextStyle(fontSize: 16, color: Colors.grey.shade600))
            ],
          ),
        ],
      ),
    );
  }
}
