import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class ChooseDateOrTime extends StatelessWidget {
  String eventDataOrTime;

  String chooseDataOrTime;

  Function onChooseDataOrTimeClicked;

  IconData? iconName;

  Color? iconColor;

  ChooseDateOrTime({
    required this.chooseDataOrTime,
    required this.eventDataOrTime,
    required this.onChooseDataOrTimeClicked,
    required this.iconName,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(
          iconName,
          color: iconColor,
        ),
        SizedBox(
          width: width * .04,
        ),
        Text(
          eventDataOrTime,
          style: AppStyle.medium16Black,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            onChooseDataOrTimeClicked();
          },
          child: Text(
            chooseDataOrTime,
            style: AppStyle.medium16Primary,
          ),
        )
      ],
    );
  }
}
