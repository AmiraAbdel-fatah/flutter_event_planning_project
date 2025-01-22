import 'package:event_planning/ui/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  // todo:  hold data  -  handel logic

  late RegisterNavigator navigator;

  Future<void> register(String email, String password) async {
    // todo: show loading
    navigator.showMyLoading('Loading....');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // // todo: add user to Fire Store
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text);
      // await FirebaseUtils.addUserToFireStore(myUser);
      // // todo: save user in provider
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUser(myUser);
      // todo: hide loading
      // todo: hide loading
      navigator.hideMyLoading();
      // todo: show message
      navigator.showMyMessage('Register Successfully.');
      // DialogUtils.showMessage(
      //     context: context,
      //     message: 'Register Successfully.',
      //     title: 'Success',
      //     posActionName: 'Ok',
      //     posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
      print('register successfully.');
      print(credential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMyMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMyMessage('The account already exists for that email.');
      } else if (e.code == "network-request-failed") {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMyMessage(
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
      }
    } catch (e) {
      // todo: hide loading
      navigator.hideMyLoading();
      // todo: show message
      navigator.showMyMessage(e.toString());
    }
  }
}
