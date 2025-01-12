import 'package:event_planning/model/my_user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  // data
  MyUser? currentUser;

  // methode
  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
