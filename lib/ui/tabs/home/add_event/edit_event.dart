import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/event.dart';
import 'package:event_planning/provider/event_list_provider.dart';
import 'package:event_planning/ui/tabs/home/tab_event_widget.dart';
import 'package:event_planning/ui/tabs/widget/choose_date_or_time.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/user_provider.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = 'edit_event';

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  // int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  DateTime? selectDate; // save date
  String formatedDate = '';
  TimeOfDay? selectTime; // save time
  String formatedTime = '';
  var titleController = TextEditingController(); // save title
  var descriptionController = TextEditingController(); // save description
  String selectedImage = '';
  String selectedEvent = '';
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);

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

    selectedImage = imageSelectedNameList[eventListProvider.selectedIndex];
    selectedEvent =
        eventListProvider.eventsNameList[eventListProvider.selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.edit_event,
          style: AppStyle.medium20Primary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * .04, vertical: height * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(selectedImage),
                //Image.asset(mapEventNameList[selectedEvent]!,
              ),
              SizedBox(
                height: height * .02,
              ),
              Container(
                height: height * .05,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: width * .02,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        eventListProvider.changeSelectedIndex(index,
                            userProvider.currentUser!.id); // select color
                        // selectedEvent = eventsNameList[index];
                        setState(() {});
                      },
                      child: TabEventWidget(
                        borderColor: AppColors.primaryLight,
                        backgroundColor: AppColors.primaryLight,
                        textSelectedStyle: AppStyle.medium16White,
                        textUnSelectedStyle: AppStyle.medium16Primary,
                        eventName: eventListProvider.eventsNameList[index],
                        isSelected: eventListProvider.selectedIndex == index,
                      ),
                    );
                  },
                  itemCount: eventListProvider.eventsNameList.length,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: AppStyle.medium16Black,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      controller: titleController,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_event_title; // invalid
                        }
                        return null; // valid
                      },
                      prefixIcon: Image.asset(AssetsManager.iconEdit),
                      hintText: AppLocalizations.of(context)!.event_title,
                      hintStyle: AppStyle.medium16Grey,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: AppStyle.medium16Black,
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
                    ChooseDateOrTime(
                      iconColor: AppColors.blackColor,
                      iconName: Icons.calendar_month_outlined,
                      chooseDataOrTime: selectDate == null
                          ? AppLocalizations.of(context)!.choose_date
                          : formatedDate
                      //DateFormat('dd/MM/yyyy').format(selectDate!)

                      //'${selectDate!.day}/${selectDate!.month}/${selectDate!.year}'
                      ,
                      eventDataOrTime: AppLocalizations.of(context)!.event_date,
                      onChooseDataOrTimeClicked: chooseDate,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    ChooseDateOrTime(
                        chooseDataOrTime: selectTime == null
                            ? AppLocalizations.of(context)!.choose_time
                            : formatedTime,
                        eventDataOrTime:
                            AppLocalizations.of(context)!.event_time,
                        onChooseDataOrTimeClicked: chooseTime,
                        iconName: Icons.access_time,
                        iconColor: AppColors.blackColor),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .02, vertical: height * .01),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.primaryLight, width: 2)),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * .02,
                                vertical: height * .01),
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
                    CustomElevatedButton(
                        text: AppLocalizations.of(context)!.update_event,
                        onButtonClicked: () {
                          EditEvent();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void EditEvent() {
    if (formKey.currentState!.validate() == true) {
      /// add event
      Event event = Event(
        title: titleController.text,
        description: descriptionController.text,
        image: selectedImage,
        eventName: selectedEvent,
        dateTime: selectDate!,
        time: formatedTime,
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      FirebaseUtils.addEventToFireStore(event, userProvider.currentUser!.id)
          .then((value) {
        // todo: alert dialog, snack bar , toast
        ToastMessage.toastMsg('Event added successfully');
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
        // print('event added successfully');
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        // todo: alert dialog, snack bar , toast
        ToastMessage.toastMsg('Event Updated successfully');
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
        Navigator.pop(context);
        // print('event added successfully');
      });
      setState(() {});
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectTime = chooseTime;
    formatedTime = selectTime!.format(context);
    setState(() {});
  }
}
