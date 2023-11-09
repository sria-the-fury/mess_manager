import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Widgets/Extras/User-Widgets/searched_user.dart';

class AddHouseMates extends StatefulWidget {
  final String houseId;
  const AddHouseMates({super.key, required this.houseId});

  @override
  State<AddHouseMates> createState() => _AddHouseMatesState();
}

class _AddHouseMatesState extends State<AddHouseMates> {
  late String typeEmail = '';
  late bool searchUser = false;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child:  Column(
        children: [
          const Text('Add House Mate', style: TextStyle(fontSize: 18),),
          const SizedBox(height: 5,),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) {
              setState(() {
                searchUser = false;
                typeEmail = email;
              });
            },
            decoration:  InputDecoration(
              prefixIcon: Icon(Icons.check_circle, color: GetUtils.isEmail(typeEmail) ? Colors.teal[600] : Colors.grey,),
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                  onPressed: GetUtils.isEmail(typeEmail) ? (){
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  setState(() {
                    searchUser = true;
                  });
                  } : null, icon: const Icon(Icons.search)),
              labelText: 'Search by email',
              floatingLabelAlignment: FloatingLabelAlignment.center,
            ),
          ),
          if(searchUser == true) Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: SearchedUser().getSearchedUser(typeEmail, widget.houseId),
          )

        ],
      ) ,
    );
  }
}
