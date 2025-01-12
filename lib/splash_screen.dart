import 'dart:async';

import 'package:event_planning/ui/on_boarding_screen/Introduction_screen.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'Splash Screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => IntroductionScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Image.asset(AssetsManager.splashScreenLogo),
            Spacer(),
            Image.asset(AssetsManager.splashBBranding),
          ],
        ),
      ),
    );
  }
}
