import 'package:car_pool/model/user_info.dart';
import 'package:car_pool/service/user_service.dart';
import 'package:car_pool/state_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../classes/themes/light_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool hiddenPassword = true;

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
              padding: EdgeInsets.all(20.0.w),
              child: Column(
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
                  10.verticalSpace,
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: LightTheme.mainTheme),
                      ),
                      labelStyle: TextStyle(
                        color: LightTheme.fontTheme,
                      ),
                      floatingLabelStyle: TextStyle(color: LightTheme.mainTheme),
                    ),
                    controller: namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Required field');
                      } else {
                        return null;
                      }
                    },
                    cursorColor: LightTheme.mainTheme,
                  ),
                  15.verticalSpace,
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
                      ),
                    ),
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
                  15.verticalSpace,
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
                  15.verticalSpace,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: LightTheme.mainTheme),
                      ),
                      labelStyle: TextStyle(
                        color: LightTheme.fontTheme,
                      ),
                      floatingLabelStyle: TextStyle(color: LightTheme.mainTheme),
                    ),
                    controller: phonecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Required field');
                      } else {
                        return null;
                      }
                    },
                    cursorColor: LightTheme.mainTheme,
                  ),
                  30.verticalSpace,
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailcontroller.text.trim();
                      String password = passwordcontroller.text.trim();
                      String phoneNumber = phonecontroller.text.trim();
                      String name = namecontroller.text.trim();

                      if (_formKey.currentState!.validate()) {
                        if (email.endsWith('@eng.asu.edu.eg')) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: (ctrl.isDriver) ? '$email.driver' : email,
                            password: password,
                          )
                              .then((value) async {
                            await UserService.initialize();
                            await UserService.addUser(
                              UserProfileInfo(
                                name: name,
                                email: (ctrl.isDriver) ? '$email.driver' : email,
                                password: password,
                                phoneNumber: phoneNumber,
                              ),
                            );
                            if (ctrl.isDriver) {
                              ctrl.fetchAllDriverData();
                            } else {
                              ctrl.fetchAllUserData();
                            }
                            ctrl.insertUserInfoLocally();
                            if (!context.mounted) return;
                            Navigator.of(context).pushNamed('/mainscreen');
                          }).catchError(
                            (error) {
                              // Handle authentication errors here
                              print('Error: $error');
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Invalid email domain. Please use @eng.asu.edu.eg',
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
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightTheme.mainTheme,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  3.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signinscreen');
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: LightTheme.mainTheme,
                              fontSize: 15,
                            ),
                          )),
                    ],
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
