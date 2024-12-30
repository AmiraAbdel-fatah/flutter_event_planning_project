import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventItemWidget extends StatelessWidget {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.work_shop,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.meeting,
    ];
    List<String> imageSelectedNameList = [
      AssetsManager.birthday,
      AssetsManager.book_club,
      AssetsManager.sports,
      AssetsManager.exhibition,
      AssetsManager.gaming,
      AssetsManager.eating,
      AssetsManager.work_shop,
      AssetsManager.holiday,
      AssetsManager.meeting,
    ];
    return Container(
      height: height * .31,
      margin: EdgeInsets.symmetric(
          // horizontal: width*.04,
          vertical: height * .01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.primaryLight,
            width: 2,
          ),
          image: DecorationImage(
              image: AssetImage(imageSelectedNameList[selectedIndex]),
              fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .01, vertical: height * .004),
            margin: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor),
            child: Column(
              children: [
                Text(
                  '22',
                  style: AppStyle.bold20Primary,
                ),
                Text(
                  'Dec',
                  style: AppStyle.bold20Primary,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .01),
            margin: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'This is a Birthday Party ',
                  style: AppStyle.bold14Black,
                ),
                Image.asset(
                  AssetsManager.iconFavorite,
                  color: AppColors.primaryLight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
