import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AssetsManager.splashScreenLogo,
              height: height * .3,
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
            Text(
              AppLocalizations.of(context)!.forget_password,
              style: AppStyle.bold16Primary.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryLight),
              textAlign: TextAlign.end,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.login,
              onButtonClicked: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
              onTap: () {
                // todo: navigate to register screen
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!
                            .do_not_have_an_account,
                        style: AppStyle.medium16Black),
                    TextSpan(
                      text: AppLocalizations.of(context)!.create_account,
                      style: AppStyle.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight),
                    ),
                  ])),
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.primaryLight,
                    endIndent: 20,
                    indent: 10,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.or,
                  style: AppStyle.medium16Primary,
                ),
                Expanded(
                  child: Divider(
                    endIndent: 10,
                    indent: 20,
                    thickness: 2,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.login_with_google,
              onButtonClicked: () {
                // todo: login with google
              },
              backgroundColor: AppColors.whiteColor,
              textStyle: AppStyle.medium20Primary,
              prefixIconButton: Image.asset(AssetsManager.iconGoogle),
            )
          ],
        ),
      ),
    );
  }
}
