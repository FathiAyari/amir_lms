import 'package:amir/ui/shared/app_colors.dart';
import 'package:amir/ui/shared/dimensions/dimensions.dart';
import 'package:amir/ui/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class CheckOtpView extends StatefulWidget {
  const CheckOtpView({Key? key}) : super(key: key);

  @override
  State<CheckOtpView> createState() => _CheckOtpViewState();
}

class _CheckOtpViewState extends State<CheckOtpView> {
  OtpFieldController otpFieldController = OtpFieldController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: pinkColor,
            elevation: 0,
            title: Text(
              "Mot de passe oublié ",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  child: Column(children: [
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
                    child: Lottie.asset("assets/lotties/forgot_password.json", height: 150),
                  )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.03, horizontal: Constants.screenWidth * 0.07),
                  child: Text(
                    "Merci de saisir le code envoyé  à votre email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Constants.screenHeight * 0.02,
                    right: Constants.screenWidth * 0.07,
                    left: Constants.screenWidth * 0.07,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: Constants.screenHeight * 0.12,
                    child: Column(
                      children: [
                        OTPTextField(
                          controller: otpFieldController,
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 15,
                          onChanged: (pin) {},
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                loading
                    ? CircularProgressIndicator()
                    : ActionButton(label: "Envoyer", buttonColor: greenColor, labelColor: Colors.white, onPressed: () {
                      Navigator.pushNamed(context, '/change_password');
                }),
              ])))),
    );
  }
}
