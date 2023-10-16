import 'package:flutter/material.dart';
import 'package:mess_manager/Widgets/Bottom-Modal-Widgets/add_house.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      bottomNavigationBar: LinearProgressIndicator(color: Colors.teal[700],),
      body:  Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Wait and Send your email to to your mate\nor\nyou can create your house and add your mates.', textAlign:
              TextAlign.center,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate,
                  child:  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: 10,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.teal[500],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const AddHouse()
                    ],
                  ));
            },
          );

        },
        child: const Icon(Icons.house, color: Colors.white,),

      ),
    );
  }
}
