import 'package:example/commons/app_dimension.dart';
import 'package:example/components/alert_widget.dart';
import 'package:example/components/button_arrow_back.dart';
import 'package:example/components/dismiss_keyboard.dart';
import 'package:example/components/square_button.dart';
import 'package:example/routes/routes_name.dart';
import 'package:example/screens/register_1/models/register_model.dart';
import 'package:example/screens/register_2/bloc/register_2_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'bloc/bloc.dart';

class Register2Screen extends StatelessWidget {
  final RegisterModel registerValue;
  Register2Screen({Key key, this.registerValue}) : super(key: key);

  final TextEditingController _nicknameCtrl = TextEditingController();
  final FocusNode _nicknameFocus = FocusNode();

  void _listenRegisterStatus(BuildContext context, Register2State state) {
    if (state is Register2Success) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesName.authen, (route) => false);
    } else if (state is Register2Failed) {
      _showRegisterError(context);
    }
  }

  void _showRegisterError(BuildContext context) {
    AlertWidget.alertDefault(
        title: 'Notification',
        desc: 'An error has occurred, please try again.',
        type: AlertType.error);
  }

  void _registerAccount(BuildContext context) {
    if (_nicknameCtrl.text.isEmpty) {
      AlertWidget.alertDefault(
          title: 'Notification',
          desc: 'Do not leave nick name blank.',
          type: AlertType.info);
    } else {
      BlocProvider.of<Register2Bloc>(context)
          .add(Register2ConfirmEvent(nickname: _nicknameCtrl.text));
      print("===============Register success===============");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<Register2Bloc>(
        create: (_) => Register2Bloc(),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => dismissKeyboard(context),
            child: SingleChildScrollView(
              child: Container(
                height: AppDimension.shared.height,
                padding: EdgeInsets.all(16),
                child: BlocListener<Register2Bloc, Register2State>(
                  listener: _listenRegisterStatus,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonArrowBack(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          "Register",
                          style: GoogleFonts.comfortaa(fontSize: 36),
                        ),
                      ),
                      _buildNicknameInput(),
                      SizedBox(height: 16),
                      _buildSignUpBtn(),
                      SizedBox(height: 32),
                      _buildRuleText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNicknameInput() {
    return TextField(
      controller: _nicknameCtrl,
      focusNode: _nicknameFocus,
      style: GoogleFonts.roboto(fontSize: 15),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: "Nick name",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2))),
      onEditingComplete: () => _nicknameFocus.unfocus(),
    );
  }

  Widget _buildSignUpBtn() {
    return BlocBuilder<Register2Bloc, Register2State>(
        builder: (context, state) {
      return SquareButton(
          onTap: () => _registerAccount(context),
          text: "SIGN UP",
          btnColor: Colors.black,
          textStyle: GoogleFonts.roboto(
              fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white));
    });
  }

  Widget _buildRuleText() {
    return RichText(
        text: TextSpan(
            text: "By signing up, you agree to Photo's ",
            style: GoogleFonts.roboto(fontSize: 13, color: Colors.black),
            children: [
          TextSpan(
              text: "Terms of Service",
              style: GoogleFonts.roboto(
                  fontSize: 13, decoration: TextDecoration.underline)),
          TextSpan(text: " and "),
          TextSpan(
              text: "Privacy Policy",
              style: GoogleFonts.roboto(
                  fontSize: 13, decoration: TextDecoration.underline)),
          TextSpan(text: "."),
        ]));
  }
}
