import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mess_manager/Route/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    debugPrint('<------ googleUser => $googleUser ----------------->');
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
        Row(
          children: [
            ElevatedButton(
              onPressed: (){
                _signInWithGoogle(context);
              },
              child: const Text('Sign in with Google'),
            ),
          ],
        ),),
    );
  }
}
