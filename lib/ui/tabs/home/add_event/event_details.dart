import 'package:event_planning/ui/tabs/home/add_event/edit_event.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../provider/event_list_provider.dart';
import '../../../../utils/assets_manager.dart';
import '../../widget/custom_text_field.dart';

class EventDetails extends StatelessWidget {
  static const String routeName = 'event details';

  late EventListProvider eventListProvider;
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(AppLocalizations.of(context)!.event_details,
            style: AppStyle.medium20Primary),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(EditEvent.routeName);
            },
            child: Icon(
              Icons.edit,
              color: AppColors.blueColor,
            ),
          ),
          SizedBox(
            width: width * .01,
          ),
          Icon(
            Icons.delete,
            color: AppColors.blueColor,
          ),
          SizedBox(
            width: width * .01,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Image.asset(AssetsManager.sports),
            ),
            SizedBox(
              height: height * .02,
            ),
            Text(
              'We Are Going To Play Football',
              style: AppStyle.bold20Primary,
            ),
            SizedBox(
              height: height * .02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .02, vertical: height * .01),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .01, vertical: height * .01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryLight,
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                  Text(
                    AppLocalizations.of(context)!.event_time,
                    style: AppStyle.medium16Primary,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .02, vertical: height * .01),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 2)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .01, vertical: height * .01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryLight,
                    ),
                    child: Icon(
                      Icons.my_location,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                  Text(
                    AppLocalizations.of(context)!.choose_event_location,
                    style: AppStyle.medium16Primary,
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryLight,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              controller: descriptionController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return AppLocalizations.of(context)!
                      .please_enter_event_description;
                }
                return null;
              },
              maxLines: 5,
              hintText: AppLocalizations.of(context)!.event_description,
              hintStyle: AppStyle.medium16Grey,
            ),
            SizedBox(
              height: height * .02,
            ),
          ],
        ),
      ),
    );
  }
}
