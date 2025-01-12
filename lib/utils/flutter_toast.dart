import 'package:fluttertoast/fluttertoast.dart';
import 'app_colors.dart';

class ToastMessage {
  static Future<bool?> toastMsg(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        fontSize: 20);
  }
}
