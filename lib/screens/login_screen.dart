import 'package:flutter/material.dart';
import 'package:mazha_app/screens/build_profile.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/internet_provider.dart';
import '../providers/sign_in_provider.dart';
import '../utils/nav_bar.dart';
import '../utils/next_screen.dart';
import '../utils/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final RoundedLoadingButtonController googleController =
  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Google Button
          RoundedLoadingButton(
            onPressed: () {
              handleGoogleSignIn();
            },
            controller: googleController,
            successColor: Colors.red,
            width: MediaQuery.of(context).size.width * 0.80,
            elevation: 0,
            borderRadius: 25,
            color: Colors.red,
            child: Wrap(
              children: const [
                Icon(
                  FontAwesomeIcons.google,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Text("Sign in with Google",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),),
    );
  }
  // handling google sigin in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                googleController.success();
                handleAfterSignInExists();
              })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                googleController.success();
                handleAfterSignIn();
              })));
            }
          });
        }
      });
    }
  }
  //handle after signin
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 400)).then((value) {
      nextScreen(context, const BuildProfile());
    });
  }
  handleAfterSignInExists() {
    Future.delayed(const Duration(milliseconds: 400)).then((value) {
      nextScreen(context, const NavBar());
    });
  }
}
