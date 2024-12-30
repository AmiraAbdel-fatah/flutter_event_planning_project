import 'package:event_planning/ui/tabs/home/tab_event_widget.dart';
import 'package:event_planning/ui/tabs/widget/choose_date_or_time.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'add_event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  DateTime? selectDate; // save date
  String formatedDate = '';
  TimeOfDay? selectTime; // save time
  String formatedTime = '';
  var titleController = TextEditingController(); // save title
  var descriptionController = TextEditingController(); // save description
  String selectedImage = '';
  String selectedEvent = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> eventsNameList = [
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

    selectedImage = imageSelectedNameList[selectedIndex];
    selectedEvent = eventsNameList[selectedIndex];

    // Map<String,String> mapEventNameList = {
    //   AppLocalizations.of(context)!.birthday : AssetsManager.birthday,
    //   AppLocalizations.of(context)!.book_club : AssetsManager.book_club,
    //   AppLocalizations.of(context)!.sport : AssetsManager.sports,
    //   AppLocalizations.of(context)!.exhibition : AssetsManager.exhibition,
    //   AppLocalizations.of(context)!.gaming : AssetsManager.gaming,
    //   AppLocalizations.of(context)!.eating : AssetsManager.eating,
    //   AppLocalizations.of(context)!.work_shop : AssetsManager.work_shop,
    //   AppLocalizations.of(context)!.holiday : AssetsManager.holiday,
    //   AppLocalizations.of(context)!.meeting : AssetsManager.meeting,
    // };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.create_event,
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
                        selectedIndex = index; // select color
                        // selectedEvent = eventsNameList[index];
                        setState(() {});
                      },
                      child: TabEventWidget(
                        borderColor: AppColors.primaryLight,
                        backgroundColor: AppColors.primaryLight,
                        textSelectedStyle: AppStyle.medium16White,
                        textUnSelectedStyle: AppStyle.medium16Primary,
                        eventName: eventsNameList[index],
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                  itemCount: eventsNameList.length,
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
                          return 'Please enter event title'; // invalid
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
                          return 'Please enter event description';
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
                      text: AppLocalizations.of(context)!.add_event,
                      onButtonClicked: addEvent,
                    ),
                  ],
                ),
              ),

              // Container(
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20)
              //   ),
              //   child: Image.asset(AssetsManager.sports),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState!.validate() == true) {
      /// add event
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
