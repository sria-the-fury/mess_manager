import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Firebase/add_house_to_db.dart';

class AddHouse extends StatefulWidget {
  final bool? isEdit;
  final String? houseName;
  final String? houseId;
  final String? houseAddress;
  const AddHouse({super.key, this.isEdit, this.houseName, this.houseId, this.houseAddress});

  @override
  State<AddHouse> createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  int _index = 0;
  late String houseName = widget.isEdit == true ? widget.houseName! : '';
  late String houseAddress = widget.isEdit == true ? widget.houseAddress! : '';

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
              return Colors.white;
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
                          && controlDetails.stepIndex == 2 && widget.isEdit != true ? () {

                        AddHouseToDB().addHouse(houseName, houseAddress);
                        Get.back(closeOverlays: true);
                      } :
                      ((houseName.isNotEmpty && houseName.trim() != widget.houseName)
                          || (houseAddress.isNotEmpty && houseAddress.trim() != widget.houseAddress!))
                          && widget.isEdit == true &&
                          controlDetails.stepIndex == 2 ? (){
                        AddHouseToDB().updateHouse(houseName,houseAddress, widget.houseId);
                        Get.back(closeOverlays: true);

                      } : null,
                      child: Text(controlDetails.stepIndex == 2 ? widget.isEdit == true ? 'Update' : 'Add' : 'Continue')),
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
                    keyboardType: TextInputType.multiline,
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
                title: const Text('Finally'),
                isActive: _index == 2 ? true : false,
                content: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(text: 'You will be the first'),
                          TextSpan(text: ' member and manager', style: TextStyle(fontWeight: FontWeight.bold),),
                          TextSpan(text: ' of this house.'),
                          TextSpan(text: ' After creating, you can'),
                          TextSpan(text: ' add your house mates.', style: TextStyle(fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
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
