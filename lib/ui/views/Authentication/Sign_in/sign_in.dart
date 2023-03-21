import 'dart:io';

import 'package:amir/core/enums/api_responses.dart';
import 'package:amir/core/services/auth_services.dart';
import 'package:amir/ui/shared/app_colors.dart';
import 'package:amir/ui/shared/dimensions/dimensions.dart';
import 'package:amir/ui/views/on_boarding/on_boarding_controller.dart';
import 'package:amir/ui/widgets/buttons/action_button.dart';
import 'package:amir/ui/widgets/inputs/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Sign_up/signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OnBoardingController controller = OnBoardingController();

  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: avoidReturnButton,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                    key: _formkey,
                    child: Container(
                      height: Constants.screenHeight * 0.9,
                      child: Column(children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: pinkColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(90),
                            ),
                          ),
                          child: Center(
                              child: Container(
                            child: Lottie.asset("assets/lotties/login.json", height: 150),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Constants.screenHeight * 0.1),
                          child: InputField(
                            label: "Email",
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            prefixWidget: Icon(
                              Icons.email,
                              color: pinkColor,
                            ),
                          ),
                        ),
                        InputField(
                          label: "Mot de passe",
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          prefixWidget: Icon(
                            Icons.lock,
                            color: pinkColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.screenWidth * 0.07, vertical: Constants.screenHeight * 0.01),
                          child: Container(
                            width: Constants.screenWidth,
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Get.toNamed("/reset_password"),
                              child: Text(
                                "mot de passe oublié?",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isLoading
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.01),
                                child: Container(child: CircularProgressIndicator()),
                              )
                            : ActionButton(
                                label: "Connecter",
                                buttonColor: greenColor,
                                labelColor: Colors.white,
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    AuthServices()
                                        .SignIn(email: emailController.text, password: passwordController.text)
                                        .then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (value == ApiResponses.success) {
                                        print(value);
                                      } else if (value == ApiResponses.wrongCridentials) {
                                        const snackBar = SnackBar(
                                            content: Text("aucun utilisateur avec les informations d'identification fournies"),
                                            backgroundColor: Colors.pink);

                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      } else if (value == ApiResponses.wrongPassword) {
                                        const snackBar =
                                            SnackBar(content: Text("Mot de passe incorrecte "), backgroundColor: Colors.pink);

                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    });
                                  }
                                }),
                        Spacer(),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextButton(
                                  child: Text("Besoin d'un nouveau compte?",
                                      style: TextStyle(color: pinkColor, fontSize: 14, fontStyle: FontStyle.italic)),
                                  onPressed: () {
                                    Get.to(SignupScreen());
                                  },
                                ))
                              ],
                            )),
                      ]),
                    )),
              ),
            )),
      ),
    );
  }
}
