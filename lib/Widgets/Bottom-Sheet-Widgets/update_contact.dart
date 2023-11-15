import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Firebase/initial_profile_update.dart';
import 'package:mess_manager/Widgets/Extras/messenger_link_instruction.dart';

class UpdateContact extends StatefulWidget {
  final bool? isEdit;
  final String? phoneNumber;
  final String? userId;
  final String? messengerLink;
  final String? whatsappNumber;
  const UpdateContact(
      {super.key,
      this.isEdit,
      this.phoneNumber,
      this.userId,
      this.messengerLink,
      this.whatsappNumber});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController whatsappTextController = TextEditingController();
  int _index = 0;
  late String phoneNumber = widget.isEdit == true ? widget.phoneNumber! : '';
  late String messengerLink =
      widget.isEdit == true ? widget.messengerLink! : '';
  late String whatsappNumber = widget.isEdit == true &&
          widget.phoneNumber! == widget.whatsappNumber!
      ? widget.phoneNumber!
      : widget.isEdit == true && widget.phoneNumber! != widget.whatsappNumber!
          ? widget.whatsappNumber!
          : '';
  late bool whatsappIsSame =
      widget.isEdit == true && widget.phoneNumber! == widget.whatsappNumber!
          ? true
          : false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stepper(
            currentStep: _index,
            connectorColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return _index == 1 ? Colors.blue : Colors.teal.shade500;
              }
              return Colors.white;
            }),
            stepIconBuilder: (index, stepState) {
              if (index == _index) {
                return index == 0
                    ? const Icon(
                        Icons.call,
                        color: Colors.white,
                      )
                    : index == 1 || index == 2
                        ? FaIcon(
                            index == 2
                                ? FontAwesomeIcons.whatsapp
                                : FontAwesomeIcons.facebookMessenger,
                            color: Colors.white)
                        : const Icon(Icons.check, color: Colors.white);
              }
              return Icon(
                Icons.check_circle,
                color: index == 0 && phoneNumber.isNotEmpty
                    ? Colors.green
                    : index == 1 && messengerLink.isNotEmpty
                        ? Colors.green
                        : index == 2 && whatsappNumber.isNotEmpty
                            ? Colors.green
                            : Colors.grey,
              );
            },
            controlsBuilder: (context, controlDetails) {
              return Row(
                children: [
                  ElevatedButton(
                      onPressed: controlDetails.stepIndex != 3
                          ? controlDetails.onStepContinue
                          : phoneNumber.isNotEmpty &&
                                  messengerLink.isNotEmpty &&
                                  whatsappNumber.isNotEmpty &&
                                  phoneNumber.length == 11 &&
                                  whatsappNumber.length == 11 &&
                                  controlDetails.stepIndex == 3 &&
                                  widget.isEdit != true
                              ? () {
                                  InitialProfileUpdate().updateSocialContact(
                                      widget.userId,
                                      phoneNumber,
                                      messengerLink,
                                      whatsappNumber);
                                }
                              : ((phoneNumber.isNotEmpty &&
                                              phoneNumber !=
                                                  widget.phoneNumber) ||
                                          (messengerLink.isNotEmpty &&
                                              messengerLink.trim() !=
                                                  widget.messengerLink!) ||
                                          (whatsappNumber.isNotEmpty &&
                                              whatsappNumber !=
                                                  widget.whatsappNumber!)) ||
                                      widget.isEdit == true &&
                                          phoneNumber.length == 11 &&
                                          whatsappNumber.length == 11 &&
                                          controlDetails.stepIndex == 3
                                  ? () {}
                                  : null,
                      child: Text(controlDetails.stepIndex == 3
                          ? widget.isEdit == true
                              ? 'UPDATE'
                              : 'ADD'
                          : 'CONTINUE')),
                  const SizedBox(
                    width: 5,
                  ),
                  if (_index > 0)
                    TextButton(
                        onPressed: controlDetails.onStepCancel,
                        child: const Text(
                          'BACK',
                        )),
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
                title: const Text('Phone Number'),
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: phoneNumber,
                        onChanged: (number) {
                          setState(() {
                            phoneNumber = number;
                            if (whatsappIsSame == true) whatsappNumber = number;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'([0-9])'),
                          )
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal[600]),
                              child: const Text(
                                '+88',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          labelText: 'Your Phone Number',
                          hintText: "01*********",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  whatsappIsSame = !whatsappIsSame;
                                  if (whatsappIsSame == true) {
                                    whatsappTextController.clear();
                                    whatsappNumber = phoneNumber;
                                  } else if (whatsappIsSame == false) {
                                    whatsappNumber = "";
                                  }
                                });
                              },
                              icon: Icon(whatsappIsSame == true
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank)),
                          const Text('Whatsapp is same as Phone?')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Step(
                title: Row(
                  children: [
                    const Text('Messenger Link'),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: '',
                              titlePadding: EdgeInsets.zero,
                              contentPadding: const EdgeInsets.only(top: 0),
                              titleStyle: const TextStyle(fontSize: 20),
                              content: const MessengerLinkInstruction());
                        },
                        icon: const Icon(Icons.info))
                  ],
                ),
                isActive: _index == 1 ? true : false,
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.url,
                        initialValue: messengerLink,
                        onChanged: (messenger) {
                          setState(() {
                            messengerLink = messenger;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Facebook Messenger Link',
                          hintText: 'https://m.me/user_name',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Whatsapp Number'),
                isActive: _index == 2 ? true : false,
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: TextFormField(
                    enabled: whatsappIsSame == true ? false : true,
                    autofocus: true,
                    controller: whatsappTextController,
                    keyboardType: TextInputType.phone,
                    onChanged: (whatsapp) {
                      setState(() {
                        whatsappNumber = whatsapp;
                      });
                    },
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.allow(
                        RegExp(r'([0-9])'),
                      )
                    ],
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10, right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.teal[600]),
                          child: const Text(
                            '+88',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      labelText: widget.isEdit == true && whatsappIsSame == true
                          ? phoneNumber
                          : widget.isEdit != true && whatsappIsSame == true
                              ? phoneNumber
                              : 'Whatsapp Number',
                      hintText: whatsappIsSame ? phoneNumber : '01*********',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                  ),
                ),
              ),
              Step(
                  title: const Text('Finally'),
                  isActive: _index == 3 ? true : false,
                  content: Row(
                    children: [
                      phoneNumber.isNotEmpty &&
                              phoneNumber.length == 11 &&
                              whatsappNumber.length == 11 &&
                              messengerLink.isNotEmpty &&
                              whatsappNumber.isNotEmpty
                          ? const Text('Everything seems fine.')
                          : const Text(
                              'Check if you left blank any data.',
                              style: TextStyle(color: Colors.red),
                            ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
