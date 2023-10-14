import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserSignInProvider extends StatelessWidget {
  final String providerId;
  const UserSignInProvider({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle),
        child: providerId == 'google.com' ? const FaIcon(  FontAwesomeIcons.google, size: 16, color: Colors.purple,) :
        providerId == 'facebook.com' ?  FaIcon(  FontAwesomeIcons.facebook, size: 16, color: Colors.blue.shade700) :
        Icon(Icons.email, size: 16, color: Colors.blue.shade700)
    );
  }
}
