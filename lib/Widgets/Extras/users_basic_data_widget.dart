import 'package:flutter/material.dart';

class UsersBasicDataWidget extends StatelessWidget {
  final String userData;
  final double? fontSize;
  final IconData iconName;
  final FontWeight? fontWeight;
  const UsersBasicDataWidget({super.key,
    required this.userData,
    this.fontSize = 16,
    required this.iconName, this.fontWeight = FontWeight.normal,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconName, size: (fontSize! + 2),),
        const SizedBox(
          width: 5,
        ),
        Text(userData, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight))
      ],
    );
  }
}
