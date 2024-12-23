import 'package:flutter/material.dart';
import 'package:introduction_slider/source/presentation/pages/introduction_slider.dart';
import 'package:introduction_slider/source/presentation/widgets/buttons.dart';
import 'package:introduction_slider/source/presentation/widgets/dot_indicator.dart';
import 'package:introduction_slider/source/presentation/widgets/introduction_slider_item.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_style.dart';
import '../home_screen/home_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = 'On boarding screen';

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IntroductionSlider(
          showStatusBar: true,
          items: [
            // IntroductionSliderItem(
            //   logo: Image(
            //       image: AssetImage(
            //           'assets/images/on_boarding_first_screen.png')),
            //   title: Text(
            //     "Personalize Your Experience",
            //     style: AppStyle.bold20Primary,
            //   ),
            //   subtitle: Text(
            //     'Choose your preferred theme and language to get started with a comfortable, '
            //     'tailored experience that suits your style.',
            //     style: AppStyle.medium16Black,
            //   ),
            //   backgroundColor: AppColors.whiteColor,
            //
            // ),
            IntroductionSliderItem(
              logo: Image(
                  image: AssetImage(
                      'assets/images/on_boarding_second_screen.png')),
              title: Text(
                "Find Events That Inspire You",
                style: AppStyle.bold20Primary,
              ),
              subtitle: Text(
                "Dive into a world of events crafted to fit your unique interests. "
                "Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. "
                "Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                style: AppStyle.medium16Black,
              ),
              backgroundColor: AppColors.whiteColor,
            ),
            IntroductionSliderItem(
              logo: Image(
                  image:
                      AssetImage('assets/images/on_boarding_third_screen.png')),
              title: Text(
                "Effortless Event Planning",
                style: AppStyle.bold20Primary,
              ),
              subtitle: Text(
                "Take the hassle out of organizing events with our all-in-one planning tools."
                " From setting up invites and managing RSVPs to scheduling reminders and coordinating details,"
                " we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
                style: AppStyle.medium16Black,
              ),
              backgroundColor: AppColors.whiteColor,
            ),
            IntroductionSliderItem(
              logo: Image(
                  image:
                      AssetImage('assets/images/on_boarding_forth_screen.png')),
              title: Text(
                "Connect with Friends & Share Moments",
                style: AppStyle.bold20Primary,
              ),
              subtitle: Text(
                "Make every event memorable by sharing the experience with others."
                " Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. "
                "Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
                style: AppStyle.medium16Black,
              ),
              backgroundColor: AppColors.whiteColor,
            ),
          ],
          done: Done(
            child: Icon(Icons.done),
            home: HomeScreen(),
          ),
          next: Next(child: Icon(Icons.arrow_forward)),
          back: Back(child: Icon(Icons.arrow_back)),
          dotIndicator: DotIndicator(),
        ),
      ),
    );
  }
}
