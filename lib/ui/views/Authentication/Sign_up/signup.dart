import 'package:amir/core/enums/api_responses.dart';
import 'package:amir/core/services/auth_services.dart';
import 'package:amir/ui/shared/app_colors.dart';
import 'package:amir/ui/shared/dimensions/dimensions.dart';
import 'package:amir/ui/widgets/buttons/action_button.dart';
import 'package:amir/ui/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  bool check = false;
  String role = 'student';

  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: pinkColor,
            elevation: 0,
            title: Text("Creér un compte"),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
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
                        padding: const EdgeInsets.only(top: 20),
                        child: InputField(
                          label: "Nom",
                          controller: nameController,
                          textInputType: TextInputType.text,
                          prefixWidget: Icon(
                            Icons.account_circle_outlined,
                            color: pinkColor,
                          ),
                        ),
                      ),
                      InputField(
                        label: "Prénom",
                        controller: lastNameController,
                        textInputType: TextInputType.text,
                        prefixWidget: Icon(
                          Icons.account_circle_outlined,
                          color: pinkColor,
                        ),
                      ),
                      InputField(
                        label: "Email",
                        controller: emailcontroller,
                        textInputType: TextInputType.emailAddress,
                        prefixWidget: Icon(
                          Icons.email,
                          color: pinkColor,
                        ),
                      ),
                      InputField(
                        label: "Mot de passe",
                        controller: passController,
                        textInputType: TextInputType.visiblePassword,
                        prefixWidget: Icon(
                          Icons.lock,
                          color: pinkColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.07),
                        child: Container(
                          width: double.infinity,
                          height: Constants.screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: DropdownButton<String>(
                            value: role,
                            underline: SizedBox(
                              height: 0,
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Apprenant(e)',
                                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                  ),
                                ),
                                value: 'student',
                              ),
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Ensengeint(e)',
                                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                  ),
                                ),
                                value: 'teacher',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                role = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      loading
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.01),
                              child: Container(child: CircularProgressIndicator()),
                            )
                          : ActionButton(
                              label: "S\'inscrire",
                              buttonColor: greenColor,
                              labelColor: Colors.white,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  AuthServices()
                                      .SignUp(
                                          name: nameController.text,
                                          email: emailcontroller.text,
                                          lastname: lastNameController.text,
                                          password: passController.text,
                                          role: role)
                                      .then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                    if (value == ApiResponses.success) {
                                      print("success");
                                    } else if (value == ApiResponses.usedEmail) {
                                      final snackBar =
                                          new SnackBar(content: new Text("Email déja utilisé "), backgroundColor: Colors.pink);

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else {
                                      final snackBar =
                                          new SnackBar(content: new Text("Erreur est survenue"), backgroundColor: Colors.pink);

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                }
                              })
                    ],
                  )))),
    );
  }
}
