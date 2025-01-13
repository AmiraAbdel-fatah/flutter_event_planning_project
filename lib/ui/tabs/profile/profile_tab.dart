import 'package:event_planning/provider/event_list_provider.dart';
import 'package:event_planning/ui/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_language_provider.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_style.dart';
import '../../home_screen/language_bottom_sheet.dart';
import '../../home_screen/theme_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var name = 'Amira';
  var email = 'amira@gmail.com';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * .20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65)),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/route_image.png'),
            SizedBox(
              width: width * .03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppStyle.bold24White,
                  ),
                  Text(email, style: AppStyle.medium16White)
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyle.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 25,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.appTheme == ThemeMode.dark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: AppStyle.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 25,
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .04, vertical: height * .02),
              child: ElevatedButton(
                  onPressed: () {
                    // todo: event list is empty
                    eventListProvider.filterList = [];
                    userProvider.currentUser = null;
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .04, vertical: height * .02),
                      backgroundColor: AppColors.redColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.logout,
                        style: AppStyle.regular20White,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
//
// // save last sura
// saveLastTheme(
//     {required String suraEnName,
//       required String suraArName,
//       required String numOfVerses}) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('suraEnName', suraEnName);
//   await prefs.setString('suraArN ame', suraArName);
//   await prefs.setString('numOfVerses', numOfVerses);
//   await loadLastSura();
// }
//
// getLastTheme() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   String suraEnName = prefs.getString('suraEnName') ?? '';
//   String suraArName = prefs.getString('suraArName') ?? '';
//   String numOfVerses = prefs.getString('numOfVerses') ?? '';
//
//   /// Map
//   return {
//     'suraEnName': suraEnName,
//     'suraArName': suraArName,
//     'numOfVerses': numOfVerses
//   };
// }
//
// // get data from shared preference
// loadLastSura() async {
//   loadSuraList = await getLastSura();
//   setState(() {});
// }
}
