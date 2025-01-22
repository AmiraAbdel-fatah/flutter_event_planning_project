import 'package:event_planning/ui/auth/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginScreenViewModel extends ChangeNotifier {
  // todo: hold data  -  handel logic

  var emailController = TextEditingController(text: 'amira22@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      // todo: show loading
      navigator.showMyLoading('Waiting....');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // var user = await FirebaseUtils.readUserFromFireStore(
        //     credential.user?.uid ?? '');
        // if (user == null) {
        //   return;
        // }
        // // todo: save user in provider
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.updateUser(user);
        // print('login successfully.');
        // print(credential.user?.uid ?? "");
        // todo: hide loading
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMyMessage('Login Successfully.');
        // DialogUtils.showMessage(
        //     context: context,
        //     message: 'Login Successfully.',
        //     title: 'Success.',
        //     posActionName: 'Ok',
        //     posAction: () {
        //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        //     });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // todo: hide loading
          navigator.hideMyLoading();
          // todo: show message
          navigator.showMyMessage('No user found for that email.');
          // // todo: show message
          // DialogUtils.showMessage(
          //     context: context,
          //     message: 'No user found for that email.',
          //     title: 'Error',
          //     posActionName: 'Ok');
          //
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // todo: hide loading
          navigator.hideMyLoading();
          // todo: show message
          navigator.showMyMessage('Wrong password provided for that user.');
          // DialogUtils.showMessage(
          //     context: context,
          //     message: 'Wrong password provided for that user.',
          //     title: 'Error',
          //     posActionName: 'Ok');

          //print('Wrong password provided for that user.');
        } else if (e.code == "invalid-credential") {
          /// todo: hide loading
          navigator.hideMyLoading();
          // todo: show message
          navigator.showMyMessage(
              'The supplied auth credential is incorrect, malformed or has expired.');
          // // todo: show message
          // DialogUtils.showMessage(
          //     context: context,
          //     message:
          //     'The supplied auth credential is incorrect, malformed or has expired.',
          //     title: 'Error',
          //     posActionName: 'Ok');
          //
          // print('The supplied auth credential is incorrect, malformed or has expired.');
          //
        } else if (e.code == "network-request-failed") {
          // todo: hide loading
          navigator.hideMyLoading();
          // todo: show message
          navigator.showMyMessage(
              'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
          // DialogUtils.showMessage(
          //     context: context,
          //     message:
          //     'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
          //     title: 'Error',
          //     posActionName: 'Ok');
          //
          // print(
          //     'The supplied auth credential is incorrect, malformed or has expired.');
        }
      } catch (e) {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMyMessage(e.toString());
        // DialogUtils.showMessage(
        //     context: context,
        //     message: e.toString(),
        //     title: 'Error',
        //     posActionName: 'Ok');
        //
        // print(e.toString());
      }
    }
  }
}
