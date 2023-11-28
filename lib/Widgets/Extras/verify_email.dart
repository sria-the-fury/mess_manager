import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  int totalSecs = 90;
  int secsRemaining = 90;
  double progressFraction = 0.0;
  int percentage = 0;
  late Timer timer;


  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      FirebaseAuth.instance.currentUser!.reload();
      if(secsRemaining == 0){
        return;
      }
      setState(() {
        secsRemaining -= 1;
        progressFraction = (totalSecs - secsRemaining) / totalSecs;
        percentage = (progressFraction*100).floor();

      });
    });
    super.initState();
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    User? authUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.teal[700],
      bottomNavigationBar: secsRemaining != 0 ? LinearProgressIndicator( value: progressFraction,) : null,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: secsRemaining == 0 ? () {
            setState(() {
              totalSecs = 90;
              secsRemaining = 90;
              progressFraction = 0.0;
            });
            if(authUser!.emailVerified == false){
              authUser.sendEmailVerification();
            }
          } : null,
              child: Text(secsRemaining == 0 ? 'Send verification link' : 'Please wait $secsRemaining secs')
          ),
          ElevatedButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
              child: const Text('Exit')
          ),
        ],
      ),
      body:  Center(
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(text: 'Hey, ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  if(authUser!.displayName != null) TextSpan(text: '${authUser.displayName.toString()}.',
                      style: const TextStyle(color: Colors.white, fontSize: 18)),
                  const TextSpan(text: '\nPlease check inbox and verify your email, ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  TextSpan(text: '${authUser.email.toString()}.',
                      style: const TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
