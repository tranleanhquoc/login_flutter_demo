import 'package:example/commons/app_dimension.dart';
import 'package:example/commons/utils/validators.dart';
import 'package:example/components/alert_widget.dart';
import 'package:example/components/button_arrow_back.dart';
import 'package:example/components/dismiss_keyboard.dart';
import 'package:example/components/square_button.dart';
import 'package:example/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'bloc/bloc.dart';

class Register1Screen extends StatelessWidget {
  Register1Screen({Key key}) : super(key: key);

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  void _listenRegisterStatus(BuildContext context, Register1State state) {
    if (state is Register1Success) {
      Navigator.of(context)
          .pushNamed(RoutesName.register2, arguments: state.registerModel);
    } else if (state is Register1Failed) {
      _showRegisterError(context);
    }
  }

  void _showRegisterError(BuildContext context) {
    AlertWidget.alertDefault(
        title: 'Notification',
        desc: 'An error has occurred, please try again.',
        type: AlertType.error);
  }

  void _moveToRegister2(BuildContext context) {
    if (_emailCtrl.text.isEmpty) {
      AlertWidget.alertDefault(
          desc: 'Do not leave email blank',
          title: 'Notification',
          type: AlertType.info);
      FocusScope.of(context).requestFocus(_emailFocus);
    } else if (!Validators.isValidEmail(_emailCtrl.text)) {
      AlertWidget.alertDefault(
          desc: 'Invalid Email', title: 'Notification', type: AlertType.info);
      FocusScope.of(context).requestFocus(_emailFocus);
    } else if (_passCtrl.text.isEmpty) {
      AlertWidget.alertDefault(
          desc: 'Do not leave password blank',
          title: 'Notification',
          type: AlertType.info);
      FocusScope.of(context).requestFocus(_passFocus);
    } else if (!Validators.isValidPassword(_passCtrl.text)) {
      AlertWidget.alertDefault(
          desc: 'Password must have 4 to 8 characters',
          title: 'Notification',
          type: AlertType.info);
      FocusScope.of(context).requestFocus(_passFocus);
    } else {
      BlocProvider.of<Register1Bloc>(context).add(Register1ConfirmEvent(
          email: _emailCtrl.text, password: _passCtrl.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => Register1Bloc(),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => dismissKeyboard(context),
            child: SingleChildScrollView(
              child: Container(
                height: AppDimension.shared.height,
                padding: EdgeInsets.all(16),
                child: BlocListener<Register1Bloc, Register1State>(
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
                      _buildEmailInput(context),
                      SizedBox(height: 16),
                      _buildPasswordInput(),
                      SizedBox(height: 16),
                      _buildRegisterBtn()
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

  Widget _buildEmailInput(BuildContext context) {
    return TextFormField(
      controller: _emailCtrl,
      focusNode: _emailFocus,
      style: GoogleFonts.roboto(fontSize: 15),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: "Email",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2))),
      onEditingComplete: () {
        _emailFocus.unfocus();
        FocusScope.of(context).requestFocus(_passFocus);
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passCtrl,
      focusNode: _passFocus,
      style: GoogleFonts.roboto(fontSize: 15),
      cursorColor: Colors.black,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: "Password",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.black, width: 2))),
      onEditingComplete: () {
        _passFocus.unfocus();
      },
    );
  }

  Widget _buildRegisterBtn() {
    return BlocBuilder<Register1Bloc, Register1State>(
        builder: (context, state) {
      return SquareButton(
          onTap: () => _moveToRegister2(context),
          text: "NEXT",
          btnColor: Colors.black,
          textStyle: GoogleFonts.roboto(
              fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white));
    });
  }
}
