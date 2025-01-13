import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/provider/user_provider.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'amira@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AssetsManager.splashScreenLogo,
                height: height * .3,
              ),
              CustomTextField(
                controller: emailController,
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
                controller: passwordController,
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
                  login();
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
    );
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      // login
      // todo: show loading
      DialogUtils.showLoading(context: context, message: 'Waiting....');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        // todo: save user in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        print('login successfully.');
        print(credential.user?.uid ?? "");
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(
            context: context,
            message: 'Login Successfully.',
            title: 'Success.',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'No user found for that email.',
              title: 'Error',
              posActionName: 'Ok');

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'Wrong password provided for that user.',
              title: 'Error',
              posActionName: 'Ok');

          print('Wrong password provided for that user.');
        } else if (e.code == "invalid-credential") {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context: context,
              message:
                  'The supplied auth credential is incorrect, malformed or has expired.',
              title: 'Error',
              posActionName: 'Ok');

          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        } else if (e.code == "network-request-failed") {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context: context,
              message:
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
              title: 'Error',
              posActionName: 'Ok');

          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        }
      } catch (e) {
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: 'Error',
            posActionName: 'Ok');

        print(e.toString());
      }
    }
  }
}
