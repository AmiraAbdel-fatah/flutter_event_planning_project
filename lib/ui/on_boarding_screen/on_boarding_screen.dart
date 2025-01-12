import 'package:event_planning/ui/auth/login/login_screen.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_style.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = 'On boarding screen';

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Image.asset(
            AssetsManager.onBoardingLogo,
          ),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * .02,
              ),
              Image.asset(
                AssetsManager.intro_img2,
                height: height * .36,
                width: width * .36,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: height * .04,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.on_boarding_title1,
                  style: AppStyle.bold20Primary,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                AppLocalizations.of(context)!.on_boarding_desc1,
                style: AppStyle.medium16Black,
              ),
              // backgroundColor: AppColors.whiteColor,
            ],

            // image:   Image.asset(AssetsManager.intro_img2,
            // height: height * .33,
          ),
        ),
        PageViewModel(
          titleWidget: Image.asset(
            AssetsManager.onBoardingLogo,
          ),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * .02,
              ),
              Image.asset(
                AssetsManager.intro_img3,
                height: height * .36,
                width: width * .36,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: height * .02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.on_boarding_title2,
                  style: AppStyle.bold20Primary,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                AppLocalizations.of(context)!.on_boarding_desc2,
                style: AppStyle.medium16Black,
              ),
            ],
          ),
        ),
        PageViewModel(
          titleWidget: Image.asset(
            AssetsManager.onBoardingLogo,
          ),
          bodyWidget:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: height * .02,
            ),
            Image.asset(
              AssetsManager.intro_img4,
              height: height * .36,
              width: width * .36,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: height * .02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.on_boarding_title3,
                style: AppStyle.bold20Primary,
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Text(
              AppLocalizations.of(context)!.on_boarding_desc3,
              style: AppStyle.medium16Black,
            ),
          ]),
        ),
      ],
      showSkipButton: true,
      showNextButton: true,
      next: Text("Next", style: AppStyle.medium16Primary),
      skip: Text("Skip", style: AppStyle.medium16Primary),
      done: Text("Done", style: AppStyle.medium16Primary),
      onDone: () {
        // On button pressed
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );

    //   Scaffold(
    //   // appBar: AppBar(
    //   //   toolbarHeight:80,
    //   //   backgroundColor: AppColors.whiteColor,
    //   //   title: Image.asset(AssetsManager.onBoardingLogo,),
    //   //   centerTitle: true,
    //   // ),
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 16),
    //     child: IntroductionSlider(
    //       showStatusBar: true,
    //       items: [
    //         IntroductionSliderItem(
    //           logo: Column(
    //             //mainAxisAlignment: MainAxisAlignment.,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Image.asset(
    //                 AssetsManager.onBoardingLogo,
    //               ),
    //               SizedBox(
    //                 height: height * .03,
    //               ),
    //               Image.asset(AssetsManager.intro_img2,
    //                 height: height * .33,
    //               ),
    //             ],
    //           ),
    //           title: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text(
    //               "\nFind Events That Inspire You",
    //               style: AppStyle.bold20Primary,
    //             ),
    //           ),
    //           subtitle: Text(
    //             "\nDive into a world of events crafted to fit your unique interests. "
    //             "Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. "
    //             "Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    //             style: AppStyle.medium16Black,
    //           ),
    //           backgroundColor: AppColors.whiteColor,
    //         ),
    //         IntroductionSliderItem(
    //           logo: Column(
    //             children: [
    //               Image.asset(AssetsManager.onBoardingLogo),
    //               SizedBox(
    //                 height: height * .05,
    //               ),
    //               Image.asset(AssetsManager.intro_img3,
    //                 height: height * .33,
    //               ),
    //             ],
    //           ),
    //           title: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text(
    //               "\nEffortless Event Planning",
    //               style: AppStyle.bold20Primary,
    //             ),
    //           ),
    //           subtitle: Text(
    //             "\nTake the hassle out of organizing events with our all-in-one planning tools."
    //             " From setting up invites and managing RSVPs to scheduling reminders and coordinating details,"
    //             " we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    //             style: AppStyle.medium16Black,
    //           ),
    //           backgroundColor: AppColors.whiteColor,
    //         ),
    //         IntroductionSliderItem(
    //           logo: Column(
    //             children: [
    //               Image.asset(AssetsManager.onBoardingLogo),
    //               SizedBox(
    //                 height: height * .03,
    //               ),
    //               Image.asset(AssetsManager.intro_img4,
    //                 height: height * .33,
    //               ),
    //             ],
    //           ),
    //           title: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text(
    //               "\nConnect with Friends & Share Moments",
    //               style: AppStyle.bold20Primary,
    //             ),
    //           ),
    //           subtitle: Text(
    //             "\nMake every event memorable by sharing the experience with others."
    //             " Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. "
    //             "Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    //             style: AppStyle.medium16Black,
    //           ),
    //           backgroundColor: AppColors.whiteColor,
    //         ),
    //       ],
    //       done: Done(
    //         child: Icon(Icons.done),
    //         home: LoginScreen(),
    //       ),
    //       next: Next(child: Icon(Icons.arrow_forward)),
    //       back: Back(child: Icon(Icons.arrow_back)),
    //       dotIndicator: DotIndicator(),
    //     ),
    //   ),
    // );
  }
}
