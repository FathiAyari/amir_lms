import 'package:amir/ui/shared/app_colors.dart';
import 'package:amir/ui/shared/dimensions/dimensions.dart';
import 'package:amir/ui/widgets/buttons/action_button.dart';
import 'package:amir/ui/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_text_field.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  OtpFieldController otpFieldController = OtpFieldController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController ConfirmNewPasswordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: pinkColor,
            elevation: 0,
            title: Text(
              "Changer mot de passe ",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  child: Column(children: [
                Container(
                  height: Constants.screenHeight * 0.2,
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
                  padding: EdgeInsets.only(top: Constants.screenHeight * 0.02),
                  child: InputField(
                      prefixWidget: Icon(Icons.lock),
                      label: "Nouveau mot de passe",
                      textInputType: TextInputType.text,
                      controller: newPasswordController),
                ),
                InputField(
                    prefixWidget: Icon(Icons.lock),
                    label: "Confirmer mot de passe",
                    textInputType: TextInputType.text,
                    controller: newPasswordController),
                SizedBox(height: 30),
                loading
                    ? CircularProgressIndicator()
                    : ActionButton(label: "Envoyer", buttonColor: greenColor, labelColor: Colors.white, onPressed: () {}),
              ])))),
    );
  }
}
