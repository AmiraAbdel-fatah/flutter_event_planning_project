import 'package:event_planning/model/event.dart';
import 'package:event_planning/provider/event_list_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class EventItemWidget extends StatelessWidget {
  // int selectedIndex = 0;
  Event event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

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
              image: AssetImage(event.image!), fit: BoxFit.fill)),
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
                  event.dateTime!.day.toString(),
                  style: AppStyle.bold20Primary,
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime!),
                  //'${event.dateTime!.month}',
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
                  event.title!,
                  style: AppStyle.bold14Black,
                ),
                InkWell(
                  onTap: () {
                    // update favorite
                    eventListProvider.updateIsFavoriteEvents(
                        event, userProvider.currentUser!.id);
                  },
                  child: Image.asset(
                    event.isFavorite == true
                        ? AssetsManager.iconFavoriteSelected
                        : AssetsManager.iconFavorite,
                    color: AppColors.primaryLight,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
