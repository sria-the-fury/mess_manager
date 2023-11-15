import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class MessengerLinkInstruction extends StatelessWidget {
  const MessengerLinkInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const Text('Messenger Link', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            const SizedBox(height: 10,),
             const Wrap(
              spacing: 2,
              runSpacing: 6,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Open'),
                    SizedBox(width: 3,),
                    FaIcon(FontAwesomeIcons.facebookMessenger),
                  ],
                ),
                Icon(Icons.trending_flat, color: Colors.grey,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tap'),
                    SizedBox(width: 3,),
                    Icon(Icons.menu),
                  ],
                ),
                Icon(Icons.trending_flat, color: Colors.grey,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tap'),
                    SizedBox(width: 3,),
                    Icon(Icons.settings),
                  ],
                ),

                Icon(Icons.trending_flat, color: Colors.grey,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tap'),
                    SizedBox(width: 3,),
                    Icon(Icons.alternate_email),
                  ],
                ),
                Icon(Icons.trending_flat, color: Colors.grey,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tap'),
                    SizedBox(width: 3,),
                    Icon(Icons.content_copy),
                    SizedBox(width: 3,),
                    Text('Copy Link'),
                  ],
                ),
                Icon(Icons.trending_flat, color: Colors.grey,),
                Text('Paste to the field')


              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  final Uri url =
                  Uri.parse('https://m.me');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.facebookMessenger, color: Colors.white),
                    SizedBox(width: 3,),
                    Text('OPEN', style: TextStyle(color: Colors.white),),
                  ],
                ))
          ]
      ),
    );
  }
}
