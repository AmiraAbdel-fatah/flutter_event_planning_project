import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_planning/provider/app_language_provider.dart';
import 'package:event_planning/provider/app_theme_provider.dart';
import 'package:event_planning/ui/on_boarding_screen/on_boarding_screen.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../utils/assets_manager.dart';

class IntroductionScreen extends StatelessWidget {
  static const String routeName = 'IntroductionScreen';

  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      //backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Image.asset(AssetsManager.onBoardingLogo),
        centerTitle: true,
        //backgroundColor: AppColors.whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * .02,
              ),
              Image.asset(
                AssetsManager.intro_img1,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: height * .03,
              ),
              Text(
                AppLocalizations.of(context)!.title_intro,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                height: height * .03,
              ),
              Text(
                AppLocalizations.of(context)!.desc_intro,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: AppStyle.medium20Primary,
                  ),
                  AnimatedToggleSwitch<String>.rolling(
                    current: languageProvider.appLanguage,
                    values: ['en', 'ar'],
                    onChanged: (value) {
                      languageProvider.changeLanguage('en');
                    },
                    iconList: [
                      Image.asset(AssetsManager.icon_english),
                      Image.asset(AssetsManager.icon_egypt),
                    ],
                    height: 40,
                    indicatorSize: Size(40, 40),
                    style: ToggleStyle(
                        backgroundColor: AppColors.transparentColor,
                        indicatorColor: AppColors.primaryLight,
                        borderColor: AppColors.primaryLight),
                  )

                  // ToggleSwitch(
                  //   minWidth: 50.0,
                  //   cornerRadius: 30.0,
                  //   activeBorders: [Border.all(color: AppColors.primaryLight,width: 2)],
                  //   activeBgColors: [[AppColors.primaryLight], [AppColors.primaryLight]],
                  //   activeFgColor: AppColors.whiteColor,
                  //   inactiveBgColor: AppColors.whiteColor,
                  //   inactiveFgColor: AppColors.primaryLight,
                  //   initialLabelIndex: 1,
                  //   totalSwitches: 2,
                  //   customWidgets: [Image.asset(AssetsManager.icon_english),
                  //     Image.asset(AssetsManager.icon_egypt),],
                  //   radiusStyle: true,
                  //   onToggle: (index) {
                  //     print('switched to: $index');
                  //   },
                  // ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: AppStyle.medium20Primary,
                  ),
                  AnimatedToggleSwitch<ThemeMode>.rolling(
                    current: themeProvider.appTheme,
                    values: [ThemeMode.light, ThemeMode.dark],
                    onChanged: (value) {
                      themeProvider.changeTheme(ThemeMode.light);

                      child:
                      themeProvider.appTheme == ThemeMode.light
                          ? getSelectedItemWidget(
                              AppLocalizations.of(context)!.light)
                          : getUnSelectedItemWidget(
                              AppLocalizations.of(context)!.light);
                      // themeProvider.changeTheme(ThemeMode.dark);
                    },
                    iconList: [
                      Image.asset(AssetsManager.icon_sun),
                      Image.asset(AssetsManager.icon_moon,
                          color: themeProvider.appTheme == ThemeMode.dark
                              ? AppColors.whiteColor
                              : null),
                    ],
                    height: 40,
                    indicatorSize: Size(40, 40),
                    style: ToggleStyle(
                        backgroundColor: AppColors.transparentColor,
                        indicatorColor: AppColors.primaryLight,
                        borderColor: AppColors.primaryLight),
                  )

                  // ToggleSwitch(
                  //   minWidth: 50.0,
                  //   cornerRadius: 30.0,
                  //   activeBorders: [Border.all(color: AppColors.primaryLight,width: 4)],
                  //   activeBgColors: [[AppColors.primaryLight], [AppColors.primaryLight]],
                  //   activeFgColor: AppColors.primaryLight,
                  //   inactiveBgColor: AppColors.whiteColor,
                  //   inactiveFgColor: AppColors.primaryLight,
                  //   initialLabelIndex: 1,
                  //   totalSwitches: 2,
                  //   customWidgets: [Image.asset(AssetsManager.icon_sun,),
                  //     Icon(Icons.nightlight,color: AppColors.whiteColor,)],
                  //   radiusStyle: true,
                  //   onToggle: (index) {
                  //     print('switched to: $index');
                  //   },
                  // ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OnBoardingScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .04, vertical: height * .02),
                      backgroundColor: AppColors.primaryLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    AppLocalizations.of(context)!.lets_start,
                    style: AppStyle.regular20White,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyle.bold20Primary,
        ),
        Icon(
          Icons.check,
          color: AppColors.primaryLight,
          size: 25,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(
      text,
      style: AppStyle.bold20Black,
    );
  }
}
