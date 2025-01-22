import 'package:event_planning/ui/auth/login/login_navigator.dart';
import 'package:event_planning/ui/auth/login/login_screen_view_model.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  var emailController = TextEditingController(text: 'amira@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  LoginScreenViewModel viewModel = LoginScreenViewModel();

  // Future<void> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //    await FirebaseAuth.instance.signInWithCredential(credential);
  //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .02,
          ),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AssetsManager.splashScreenLogo,
                  height: height * .3,
                ),
                CustomTextField(
                  controller: viewModel.emailController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter email'; // invalid
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return "Please enter email valid";
                    }
                    return null; // valid
                  },
                  hintText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: AppColors.greyColor,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  controller: viewModel.passwordController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter password'; // invalid
                    }

                    if (text.length < 6) {
                      return "Password should be at least 6 characters";
                    }
                    return null; // valid
                  },
                  obSecureText: true,
                  keyboardType: TextInputType.number,
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
                    viewModel.login();
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
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                  onButtonClicked: ()
                      //async
                      {
                    // todo: login with google
                    // await signInWithGoogle();
                  },
                  backgroundColor: AppColors.whiteColor,
                  textStyle: AppStyle.medium20Primary,
                  prefixIconButton: Image.asset(AssetsManager.iconGoogle),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading(String message) {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(
        context: context, message: message, posActionName: 'Ok');
  }
}
