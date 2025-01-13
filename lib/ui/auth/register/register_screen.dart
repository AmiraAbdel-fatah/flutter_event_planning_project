import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/my_user.dart';
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

import '../../../provider/user_provider.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_screen';
  var nameController = TextEditingController(text: 'Amira');
  var emailController = TextEditingController(text: 'amira@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  controller: nameController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter name'; // invalid
                    }
                    return null; // valid
                  },
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
                      return "Please enter valid email";
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
                  keyboardType: TextInputType.phone,
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
                  controller: rePasswordController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter re-password'; // invalid
                    }
                    if (text.length < 6) {
                      return "Password should be at least 6 characters.";
                    }
                    if (text != passwordController.text) {
                      return "Re_Password doesn’t match password.";
                    }
                    return null; // valid
                  },
                  obSecureText: true,
                  keyboardType: TextInputType.number,
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
                    register(context);
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
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
      ),
    );
  }

  Future<void> register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      // register
      // todo: show loading
      DialogUtils.showLoading(context: context, message: 'Loading....');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // todo: add user to Fire Store
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        // todo: save user in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(
            context: context,
            message: 'Register Successfully.',
            title: 'Success',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('register successfully.');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'The password provided is too weak.',
              title: 'Error',
              posActionName: 'Ok');

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              title: 'Error',
              posActionName: 'Ok');

          print('The account already exists for that email.');
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

        print(e);
      }
    }
  }
}
