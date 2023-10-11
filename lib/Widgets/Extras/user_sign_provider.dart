import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserSignInProvider extends StatelessWidget {
  final String providerId;
  const UserSignInProvider({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,),
        child: providerId == 'google.com' ? const FaIcon(  FontAwesomeIcons.google, size: 16,) :
        providerId == 'facebook.com' ?  FaIcon(  FontAwesomeIcons.facebook, size: 16, color: Colors.blue.shade700) :
            const Icon(Icons.email)
    );
  }
}
