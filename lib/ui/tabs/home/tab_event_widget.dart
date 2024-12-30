import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

class TabEventWidget extends StatelessWidget {
  bool isSelected;
  String eventName;
  Color backgroundColor;
  Color? borderColor;
  TextStyle textSelectedStyle;
  TextStyle textUnSelectedStyle;

  TabEventWidget(
      {super.key,
      this.borderColor,
      required this.eventName,
      required this.isSelected,
      required this.backgroundColor,
      required this.textSelectedStyle,
      required this.textUnSelectedStyle});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * .02, vertical: height * .007),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: borderColor ?? AppColors.whiteColor,
          width: 1,
        ),
        color: isSelected ? backgroundColor : AppColors.transparentColor,
      ),
      child: Text(
        eventName,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
      ),
    );
  }
}
