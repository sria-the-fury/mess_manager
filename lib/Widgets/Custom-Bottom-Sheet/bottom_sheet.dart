import 'package:flutter/material.dart';

class CustomBottomSheet {
  showBottomSheet(context, Widget sheetWidget){
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Wrap(
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
                sheetWidget
              ],
            ));
      },
    );
  }

}
