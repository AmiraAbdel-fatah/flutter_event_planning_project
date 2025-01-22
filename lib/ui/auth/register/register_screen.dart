import 'package:event_planning/ui/auth/register/register_navigator.dart';
import 'package:event_planning/ui/auth/register/register_screen_view_model.dart';
import 'package:event_planning/ui/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var nameController = TextEditingController(text: 'Amira');

  var emailController = TextEditingController(text: 'amira22@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  var rePasswordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this; // pointer to RegisterScreenState
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
      ),
    );
  }

  Future<void> register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      //   // register
      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    //Navigator.pop(context);
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
