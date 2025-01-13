import 'package:event_planning/provider/event_list_provider.dart';
import 'package:event_planning/ui/tabs/home/event_item_widget.dart';
import 'package:event_planning/ui/tabs/home/tab_event_widget.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import 'add_event/event_details.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    var eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: AppColors.primaryLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyle.regular14White,
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyle.bold24White,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.sunny,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  width: width * .02,
                ),
                Container(
                  margin: EdgeInsets.only(right: width * .01),
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .01, vertical: height * .01),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.whiteColor),
                  child: Text(
                    'EN',
                    style: AppStyle.bold14Primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            height: height * .12,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap),
                    SizedBox(
                      width: width * .01,
                    ),
                    Text(
                      'cairo, Egypt',
                      style: AppStyle.medium14White,
                    )
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                DefaultTabController(
                    length: eventListProvider.eventsNameList.length,
                    child: TabBar(
                        onTap: (index) {
                          eventListProvider.changeSelectedIndex(
                              index, userProvider.currentUser!.id);
                        },
                        tabAlignment: TabAlignment.start,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: width * .01),
                        isScrollable: true,
                        tabs: eventListProvider.eventsNameList.map((eventName) {
                          return TabEventWidget(
                            backgroundColor: AppColors.whiteColor,
                            textSelectedStyle: AppStyle.medium16Primary,
                            textUnSelectedStyle: AppStyle.medium16White,
                            eventName: eventName,
                            isSelected: eventListProvider.selectedIndex ==
                                eventListProvider.eventsNameList
                                    .indexOf(eventName),
                          );
                        }).toList())),
              ],
            ),
          ),
          Expanded(
            child: eventListProvider.filterList.isEmpty
                ? Center(
                    child: Text(
                      'No Event Found',
                      style: AppStyle.medium20Primary,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .02),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, EventDetails.routeName);
                            },
                            child: EventItemWidget(
                              event: eventListProvider.filterList[index],
                            )),
                      );
              },
                    itemCount: eventListProvider.filterList.length,
                  ),
          )
        ],
      ),
    );
  }

// void getAllEvents()async{
//   //print('in first getAllEvents');
//   QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
//   // List <Event>       List<QueryDocumentSnapshot<Event>>
//   eventsList = querySnapshot.docs.map((doc){
//     return doc.data();
//   }).toList();
//   //print('in end getAllEvents');
//   setState(() {
//
//   });
//
// }
}
