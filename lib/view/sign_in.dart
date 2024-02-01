// ignore_for_file: avoid_print

import 'package:car_pool/state_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../classes/themes/light_theme.dart';
import '../service/user_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool hiddenPassword = true;
  bool beDriver = false;

  late StateController stateController;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, ctrl, child) {
      stateController = ctrl;
      return SafeArea(
        child: Scaffold(
          backgroundColor: LightTheme.backgroundTheme,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      createSwitch(),
                    ],
                  ),
                  Image.network(
                    'https://nbsle.scu.eg/images/universities/3/eng.png',
                    height: 200.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: LightTheme.mainTheme),
                        ),
                        labelStyle: TextStyle(
                          color: LightTheme.fontTheme,
                        ),
                        floatingLabelStyle: TextStyle(color: LightTheme.mainTheme),
                        suffixIcon: IconButton(
                          onPressed: () {
                            ctrl.toggleDriverMode();
                          },
                          icon: Icon(
                            (ctrl.isDriver) ? Icons.drive_eta : Icons.person,
                            color: LightTheme.decline,
                          ),
                        )),
                    controller: emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Required field');
                      } else {
                        return null;
                      }
                    },
                    cursorColor: LightTheme.mainTheme,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: hiddenPassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: LightTheme.mainTheme),
                      ),
                      labelStyle: TextStyle(color: LightTheme.fontTheme),
                      floatingLabelStyle: TextStyle(color: LightTheme.mainTheme),
                      suffixIcon: IconButton(
                        onPressed: () {
                          togglePassword();
                        },
                        icon: Icon(
                          hiddenPassword ? Icons.visibility : Icons.visibility_off,
                          color: LightTheme.fontTheme,
                        ),
                        splashRadius: 20,
                      ),
                    ),
                    controller: passwordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Required field');
                      } else {
                        return null;
                      }
                    },
                    cursorColor: LightTheme.mainTheme,
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailcontroller.text.trim();
                      String password = passwordcontroller.text.trim();
                      if (_formKey.currentState!.validate()) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: (ctrl.isDriver) ? '$email.driver' : email,
                          password: password,
                        )
                            .then((value) async {
                          await UserService.initialize();
                          if (ctrl.isDriver) {
                            ctrl.fetchAllDriverData();
                          } else {
                            ctrl.fetchAllUserData();
                          }
                          ctrl.updateUserInfoLocally();
                          if (!context.mounted) return;
                          Navigator.of(context).pushNamed('/mainscreen');
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'email/password is incorrect',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightTheme.mainTheme,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  togglePassword() {
    hiddenPassword = !hiddenPassword;
    setState(() {});
  }

  Widget createSwitch() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 16.0),
      child: FlutterSwitch(
        activeColor: LightTheme.mainTheme,
        inactiveColor: LightTheme.secondarybackgroundTheme,
        activeIcon: const Icon(
          Icons.nightlight_round,
        ),
        inactiveIcon: const Icon(
          Icons.wb_sunny,
        ),
        width: 50.0.w,
        height: 30.0.h,
        toggleSize: 20.0.r,
        value: stateController.darkMode,
        borderRadius: 15.0.r,
        padding: 6.0.w,
        onToggle: (val) {
          stateController.toggleThemeMode();
        },
      ),
    );
  }
}
