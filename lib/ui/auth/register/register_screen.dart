import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyle.medium16Black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AssetsManager.splashScreenLogo,
                height: height * .28,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Icon(
                  Icons.person,
                  color: AppColors.greyColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: AppColors.greyColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                obSecureText: false,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: AppColors.greyColor,
                ),
                suffixIcon: Image.asset(AssetsManager.show_password),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                obSecureText: false,
                hintText: AppLocalizations.of(context)!.re_password,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: AppColors.greyColor,
                ),
                suffixIcon: Image.asset(AssetsManager.show_password),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomElevatedButton(
                onButtonClicked: () {
                  // navigate to home screen (register)
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
                text: AppLocalizations.of(context)!.create_account,
              ),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                onTap: () {
                  // todo: navigate to login screen
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!
                              .already_have_an_account,
                          style: AppStyle.medium16Black),
                      TextSpan(
                        text: AppLocalizations.of(context)!.login,
                        style: AppStyle.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight),
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
