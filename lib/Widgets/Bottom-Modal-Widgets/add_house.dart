import 'package:flutter/material.dart';
import 'package:mess_manager/Methods/Firebase/add_house_to_db.dart';

class AddHouse extends StatefulWidget {
  const AddHouse({super.key});

  @override
  State<AddHouse> createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  int _index = 0;
  late String houseName = '';
  late String houseAddress = '';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stepper(
            currentStep: _index,
            onStepTapped: null,
            connectorColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains( MaterialState.selected)){
                return Colors.teal.shade500;
              }
              return Colors.grey.shade400;
            }),
            stepIconBuilder: (index, stepState){
              if(index == _index ) {
                return Icon(index == 0 ? Icons.home :
                index == 1 ? Icons.location_on : Icons.check, color: Colors.white,);
              }
              return Icon(Icons.check_circle,
                color: index == 0 && houseName.isNotEmpty ? Colors.green :
                index == 1 && houseAddress.isNotEmpty ? Colors.green : Colors.grey,);

            },
            controlsBuilder: (context, controlDetails) {
              return Row(
                children: [
                  ElevatedButton(
                      onPressed: controlDetails.stepIndex != 2 ?
                      controlDetails.onStepContinue :
                      houseName.isNotEmpty && houseAddress.isNotEmpty
                          && controlDetails.stepIndex == 2 ? () {
                        AddHouseToDB().addHouse(houseName, houseAddress);
                      } : null,
                      child: Text(controlDetails.stepIndex == 2 ? 'Submit' : 'Continue')),
                  const SizedBox(width: 5,),
                  if(_index > 0)TextButton(
                      onPressed: controlDetails.onStepCancel,
                      child: const Text('Back',)),
                ],
              );
            },
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () {
              if (_index >= 0) {
                setState(() {
                  _index += 1;
                });
              }
            },
            steps: <Step>[
              Step(
                isActive: _index == 0 ? true : false,
                label: const Icon(Icons.home),
                title: const Text('House Name '),
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: TextFormField(
                    initialValue: houseName,
                    onChanged: (house) {
                      setState(() {
                        houseName = house;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Give a house name',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text('Address'),
                isActive: _index == 1 ? true : false,
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: TextFormField(
                    autofocus: true,
                    initialValue: houseAddress,
                    onChanged: (address) {
                      setState(() {
                        houseAddress = address;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text('Submit'),
                isActive: _index == 2 ? true : false,
                content: Column(
                  children: [
                    const Text('You are the first member of this house. After creating you can add your mates.'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.home),
                        const SizedBox(width: 5,),
                        Text(houseName.isNotEmpty ? houseName :
                        'Add house name'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 5,),
                        Text(houseAddress.isNotEmpty ? houseAddress : 'Add Address'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
