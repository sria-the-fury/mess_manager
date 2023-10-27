import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mess_manager/Methods/Firebase/initial_profile_update.dart';
import 'package:mess_manager/Widgets/Extras/custom_get_snackbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool showPassword = false;
  late String typeEmail = '';
  late String typePassword = '';
  late String typeName = '';
  late bool signup = false;
  late bool createLoading = false;

  validateName() {
    final RegExp nameRegX = RegExp(r'^[a-zA-z]+(\s[a-zA-Z]+)+$');
    if (nameRegX.hasMatch(typeName)) {
      return true;
    }
    return false;
  }

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
    }
  }

  _signupWithEmailAndPassword() async {
    setState(() {
      createLoading = true;
    });
    try{
      final signupResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: typeEmail, password: typePassword);
      InitialProfileUpdate().updateDisplayName(typeName, signupResult.user!.uid);
      if (signupResult.user!.emailVerified == false) {
        signupResult.user!.sendEmailVerification();
      }

    } on FirebaseAuthException catch (e){
      debugPrint('e.code => ${e.code}');
      setState(() {
        createLoading = false;
      });
      if(e.code == 'account-exists-with-different-credential'){
        CustomGetSnackbar().error('SIGN UP', 'You have an account using by ${e.credential}');
      }
      else if (e.code == 'weak-password') {
        CustomGetSnackbar().error('SIGN UP', 'The password provided is too weak.');
      }
      else if (e.code == 'email-already-in-use') {
        CustomGetSnackbar().error('SIGN UP', 'The account already exists for that email.');
      }

      else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        CustomGetSnackbar().error('SIGN UP', 'Invalid credentials. Try using Google or Facebook.');
      }
    }

  }

  _signInWithEmailAndPassword() async {
    setState(() {
      createLoading = true;
    });
    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: typeEmail, password: typePassword);

    } on FirebaseAuthException catch (e){
      debugPrint('e.code => ${e.code}');
      setState(() {
        createLoading = false;
      });
      if(e.code == 'account-exists-with-different-credential'){
        CustomGetSnackbar().error('LOG IN', 'You have an account using by ${e.credential}.');
      }
      else if (e.code == 'weak-password') {
        CustomGetSnackbar().error('LOG IN', 'The password provided is too weak.');
      }

      else if (e.code == 'user-not-found') {
        CustomGetSnackbar().error('LOG IN', 'No user found for that email.');
      }
      else if (e.code == 'wrong-password') {
        CustomGetSnackbar().error('LOG IN', 'Wrong password provided for that user.');
      }
      else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        CustomGetSnackbar().error('LOG IN', 'Invalid credentials. Try using Google or Facebook.');
      }
    }

  }

  _signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final isSigning = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (isSigning.additionalUserInfo!.isNewUser) {
        final fbImageUrl =
            isSigning.additionalUserInfo!.profile!['picture']['data']['url'];
        final userID = isSigning.user!.uid;
        debugPrint('suerOF => $userID');
        InitialProfileUpdate().updatePhoto(fbImageUrl, userID);
      }
      // debugPrint('---> Is Signing => ${isSigning.additionalUserInfo!.profile!['picture']['data']['url']}');
      debugPrint(
          '---> Is Signing => ${isSigning.additionalUserInfo!.isNewUser}');
      // debugPrint('---> User => {$user}');
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

  @override
  Widget build(BuildContext context) {
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
                    if (signup == true)
                      Column(
                        children: [
                          TextFormField(
                            onChanged: (name) {
                              setState(() {
                                typeName = name;
                              });
                            },
                            initialValue: typeName,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelStyle: const TextStyle(color: Colors.white),
                                labelText: 'Enter Name',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                filled: true,
                                fillColor:
                                    typeName.isNotEmpty && !validateName()
                                        ? Colors.red
                                        : Colors.teal[400],
                                focusColor: Colors.teal[400],
                                contentPadding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    TextFormField(
                      onChanged: (email) {
                        setState(() {
                          typeEmail = email.removeAllWhitespace;
                        });
                      },
                      initialValue: typeEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle:
                              const TextStyle(color: Colors.white),
                          labelText: 'Enter Email',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: typeEmail.isNotEmpty &&
                                  !GetUtils.isEmail(typeEmail)
                              ? Colors.red
                              : Colors.teal[400],
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
                          ),
                          suffixIcon: GetUtils.isEmail(typeEmail)
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : null),
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
                          floatingLabelStyle:
                              const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor:
                              typePassword.isNotEmpty && typePassword.length < 6
                                  ? Colors.red
                                  : Colors.teal[400],
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
                        if (signup == false)
                          const Text(
                            'Forget password?',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        if (signup == true)
                          ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: () => setState(() {
                              signup = false;
                            }),
                            child: const Text('Have an Account? Log in'),
                          ),
                        if (signup == true)
                          ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: typeEmail.isNotEmpty &&
                                    typeName.isNotEmpty &&
                                    !createLoading &&
                                    validateName() &&
                                    typePassword.isNotEmpty &&
                                    typePassword.length >= 6 &&
                                    GetUtils.isEmail(typeEmail)
                                ? () => _signupWithEmailAndPassword()
                                : null,
                            child: createLoading == true
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3.0,
                                    ))
                                : const Text('Sign up'),
                          ),
                        if (signup == false)
                          ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: typeEmail.isNotEmpty &&
                                    !createLoading &&
                                    typePassword.isNotEmpty &&
                                    typePassword.length >= 6 &&
                                    GetUtils.isEmail(typeEmail)
                                ? () => _signInWithEmailAndPassword()
                                : null,
                            child: createLoading == true
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3.0,
                                    ))
                                : const Text('Login'),
                          )
                      ],
                    ),
                    if (signup == false)
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: () => setState(() {
                              signup = true;
                            }),
                            child: const Text('New? Sign up with Email'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Sing in without password',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        _signInWithGoogle();
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.deepPurple,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _signInWithFacebook();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
