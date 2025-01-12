import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../firebase_utils.dart';
import '../model/event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/flutter_toast.dart';

class EventListProvider extends ChangeNotifier {
// 1-data      2-methode
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<Event> filterList = [];
  List<Event> favoriteList = []; // filter
  List<Event> favoriteEventList = [];

  // favorite
  // filter (eventName)
  // List<String> eventsNameList = [
  //   'All',
  //   'Birthday',
  //   "BookClub",
  //   'Sport',
  //   'Exhibition',
  //   'Gaming',
  //   'Eating',
  //   'WorkShop',
  //   'Holiday',
  //   'Meeting',
  // ];
  List<String> eventsNameList = [];

  void getEventNameList(BuildContext context) {
    eventsNameList = [
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
  }

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();
    // List <Event>       List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventsList;
    // todo: Sorting
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime!.compareTo(event2.dateTime!);
    });
    notifyListeners();
  }

  // void getFilterEvents()async{
  //   QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection()
  //       .where('eventName',isEqualTo: eventsNameList[selectedIndex]).get();
  //   // List <Event>       List<QueryDocumentSnapshot<Event>>
  //   // todo: get all events.
  //   eventsList = querySnapshot.docs.map((doc){
  //     return doc.data();
  //   }).toList();
  //   // todo:  Filter List
  //   filterList = eventsList.where((event){
  //     return event.eventName == eventsNameList[selectedIndex];
  //   }
  //   ).toList();
  //   // todo:  Sorting
  //   filterList.sort((Event event1 , Event event2){
  //     return event1.dateTime!.compareTo(event2.dateTime!);
  //   });
  //   notifyListeners();
  //
  // }

  void getFilterEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .where('eventName', isEqualTo: eventsNameList[selectedIndex])
            .get();
    // List <Event>       List<QueryDocumentSnapshot<Event>>
    // todo: get all events.
    filterList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    // todo:  Filter List
    // filterList = eventsList.where((event){
    //   return event.eventName == eventsNameList[selectedIndex];
    // }
    // ).toList();
    // todo:  Sorting
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime!.compareTo(event2.dateTime!);
    });
    notifyListeners();
  }

  void updateIsFavoriteEvents(Event event, String uId) async {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite}).then((value) {
      ToastMessage.toastMsg('Event updated successfully');
    }).timeout(Duration(milliseconds: 500), onTimeout: () {
      ToastMessage.toastMsg('Event updated successfully');
    });
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
    getFavoriteEvent(uId);
    //notifyListeners();
  }

  void getFavoriteEvent(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
        .orderBy('dataTime', descending: false)
        .where('isFavorite', isEqualTo: true)
        .get();
    favoriteEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      // todo: All
      getAllEvents(uId);
    } else {
      getFilterEvents(uId);
    }
  }
}
