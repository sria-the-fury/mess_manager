import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Firebase/initial_profile_update.dart';
class UpdateProfessionHometown extends StatefulWidget {
  final bool? isEdit;
  final String? role;
  final String userId;
  final String? orgName;
  final String? homeTown;
  const UpdateProfessionHometown({super.key, this.isEdit, this.role, this.orgName, this.homeTown, required this.userId});

  @override
  State<UpdateProfessionHometown> createState() => _UpdateProfessionHometownState();
}

class _UpdateProfessionHometownState extends State<UpdateProfessionHometown> {
  int _index = 0;
  late String role = widget.isEdit == true && widget.role != null ? widget.role! : '';
  late String orgName = widget.isEdit == true && widget.orgName != null ? widget.orgName! : '';
  late String homeTown = widget.isEdit == true && widget.homeTown != null ? widget.homeTown! : '';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stepper(
            currentStep: _index,
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            connectorColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.teal.shade500;
              }
              return Colors.white;
            }),
            stepIconBuilder: (index, stepState) {
              if (index == _index) {
                return index == 0
                    ? const Icon(
                  Icons.badge,
                  color: Colors.white,
                )
                    : index == 1
                    ? const Icon(Icons.location_city,
                    color: Colors.white)
                    : const Icon(Icons.check, color: Colors.white);
              }
              return Icon(
                Icons.check_circle,
                color: index == 0 &&
                    role.isNotEmpty &&
                    role.length > 2 &&
                    orgName.isNotEmpty &&
                    orgName.length > 5
                    ? Colors.green
                    : index == 1 &&
                    homeTown.isNotEmpty &&
                    homeTown.length > 5
                    ? Colors.green
                    : Colors.grey,
              );
            },
            controlsBuilder: (context, controlDetails) {
              return Row(
                children: [
                  ElevatedButton(
                      onPressed: controlDetails.stepIndex != 2
                          ? controlDetails.onStepContinue
                          : ((role.length > 2  && orgName.length > 5  && homeTown.length > 5)
                          || (role.length > 2  &&
                          orgName.length > 5 && homeTown.isEmpty) ||
                          (homeTown.length > 5 && role.isEmpty && orgName.isEmpty)) &&
                          widget.isEdit != true && controlDetails.stepIndex == 2
                          ? () {
                        InitialProfileUpdate().updateProfAndHome(
                            widget.userId, homeTown, role, orgName);
                        Get.back(closeOverlays: true);
                      }
                          : (((widget.role != null && role != widget.role)
                          || (widget.orgName != null && orgName != widget.orgName)
                          && role.length > 2 && orgName.length > 5 && homeTown.length > 5) ||
                          ((widget.role == null && widget.orgName == null)
                                  && role.length > 2 && orgName.length > 5 && homeTown.length > 5) ||
                          ((widget.role == role && widget.orgName == orgName)
                              && role.length > 2 && orgName.length > 5 && homeTown.length > 5
                              && (homeTown != widget.homeTown && widget.homeTown != null)) ||
                          ((widget.role == role && widget.orgName == orgName)
                              && role.length > 2 && orgName.length > 5 && homeTown.length > 5
                              &&  widget.homeTown == null) ||
                          (role.length > 2 && orgName.length > 5 && homeTown.isEmpty
                              && (role != widget.role || orgName != widget.orgName))
                          ||
                          (homeTown.length > 5 && role.isEmpty && orgName.isEmpty && homeTown != widget.homeTown)) &&
                          widget.isEdit == true &&
                          controlDetails.stepIndex == 2
                          ? () {
                        InitialProfileUpdate().updateProfAndHome(
                            widget.userId, homeTown, role, orgName);
                        Get.back(closeOverlays: true);
                        Get.back(closeOverlays: true);
                      }
                          : null,
                      child: Text(controlDetails.stepIndex == 2
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
                title: const Text('Role and Organization'),
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: role,
                        onChanged: (userWorkRole) {
                          setState(() {
                            role = userWorkRole;
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[A-Za-z]+[A-Za-z ]*$')
                          )
                        ],
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.engineering),
                          labelText: 'Role',
                          hintText: "Student",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        initialValue: orgName,
                        onChanged: (org) {
                          setState(() {
                            orgName = org;
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[A-Za-z]+[A-Za-z .]*$')
                          )
                        ],
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.work),
                          labelText: 'Work Place',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Home Town'),
                isActive: _index == 1 ? true : false,
                content: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.url,
                        initialValue: homeTown,
                        onChanged: (home) {
                          setState(() {
                            homeTown = home;
                          });
                        },

                        decoration: const InputDecoration(
                          labelText: 'Home Town',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                  title: const Text('Finally'),
                  isActive: _index == 2 ? true : false,
                  content: Column(
                    children: [
                      Row(
                        children: [
                          role.isNotEmpty &&
                              role.length > 2  &&
                              orgName.isNotEmpty &&
                              orgName.length > 5 &&
                              homeTown.isNotEmpty &&
                              homeTown.length > 5
                              ? const Text('Everything seems fine.')
                              : const Text(
                            'Check if you left any blank.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
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
