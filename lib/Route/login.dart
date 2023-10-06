import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool showPassword = false;
  late String typeEmail='';
  late String typePassword='';

  _signInWithGoogle() async {
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

      // if (user != null) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => const Home(),
      //     ),
      //   );
      // }
    }
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  _signInWithEmailAndPassword() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: typeEmail, password: typePassword);
    User? currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified == false ) {
      await currentUser.sendEmailVerification();
    }

  }
  _signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile']
    );
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider
          .credential(loginResult.accessToken!.token);
      var isSigning = await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential);
      // debugPrint('---> Is Signing => ${isSigning.additionalUserInfo!.profile!['picture']['data']['url']}');
      debugPrint('---> Is Signing => ${isSigning.additionalUserInfo!.isNewUser}');
      User? user = FirebaseAuth.instance.currentUser;
      if(isSigning.additionalUserInfo!.isNewUser){
        final createUser = FirebaseFunctions.instance.httpsCallable('createProfile');
        createUser({'fbPhotoUrl': isSigning.additionalUserInfo!.profile!['picture']['data']['url'],
          'signingProvider': 'FACEBOOK'});

      }
      // debugPrint('---> User => {$user}');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('isEmail => ${GetUtils.isEmail(typeEmail)}');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Colors.teal[700],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.teal[500],
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'M',
                      style: TextStyle(fontSize: 60, color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ess',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text('anager',
                            style: TextStyle(fontSize: 18, color: Colors.white))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (email) {
                        setState(() {
                          typeEmail = email;
                        });
                      },
                      initialValue: typeEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelText: 'Enter Email',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.teal[400],
                          focusColor: Colors.teal[400],
                          contentPadding:
                              const EdgeInsets.only(top: 15, bottom: 15),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (password) {
                        setState(() {
                          typePassword = password;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          labelText: 'Enter Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          filled: true,
                          fillColor: Colors.teal[400],
                          contentPadding:
                              const EdgeInsets.only(top: 15, bottom: 15),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(
                                  showPassword == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Forget password?', style: TextStyle(color: Colors.white, fontSize: 15),),
                        ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: typeEmail.isNotEmpty &&
                              typePassword.isNotEmpty && typePassword.length >= 6 && GetUtils.isEmail(typeEmail) ?
                              () => _signInWithEmailAndPassword() : null,
                          child: const Text('Login'),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {},
                      child: const Text('New? Sign up with Email'),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0 ? null : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _signInWithGoogle();
            },
            child: const FaIcon(FontAwesomeIcons.google),
          ),
          ElevatedButton(
            onPressed: () {
              _signInWithFacebook();
            },
            child: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue.shade700,),
          ),
        ],
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
