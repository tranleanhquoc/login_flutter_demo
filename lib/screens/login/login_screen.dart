import 'package:example/commons/app_dimension.dart';
import 'package:example/commons/utils/validators.dart';
import 'package:example/components/button_arrow_back.dart';
import 'package:example/components/dismiss_keyboard.dart';
import 'package:example/components/square_button.dart';
import 'package:example/data/repository/authentication_repository.dart';
import 'package:example/screens/authentication/bloc/authentication_bloc.dart';
import 'package:example/screens/authentication/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../commons/utils/validators.dart';
import 'bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  void _listenLoginStatus(BuildContext context, LoginState state) {
    if (state.status.isSubmissionFailure) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              content: Text(
            'Log in failed!',
            style: GoogleFonts.roboto(fontSize: 13),
            textAlign: TextAlign.center,
          )),
        );
    }
    if (state.status.isSubmissionSuccess) {
      BlocProvider.of<AuthenticationBloc>(context).add(
          AuthenticationStatusChanged(
              status: AuthenticationStatus.authenticated));
    }
  }

  String _validateEmail(LoginState state) {
    if (state.email.invalid)
      return 'Not be empty';
    else if (state.email.valid && !Validators.isValidEmail(state.email.value))
      return 'Invalid email';

    return null;
  }

  String _validatePassword(LoginState state) {
    if (state.password.invalid)
      return 'Not be empty';
    else if (state.password.valid &&
        !Validators.isValidPassword(state.password.value))
      return 'Password must have 4 to 8 characters';

    return null;
  }

  bool _validateLogin(LoginState state, BuildContext context) =>
      state.status.isValid &&
      Validators.isValidEmail(state.email.value) &&
      Validators.isValidPassword(state.password.value);

  void _onLoginTapped(LoginState state, BuildContext context) {
    dismissKeyboard(context);
    if (_validateLogin(state, context))
      context.read<LoginBloc>().add(LoginSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => dismissKeyboard(context),
            child: SingleChildScrollView(
              child: Container(
                height: AppDimension.shared.height,
                padding: EdgeInsets.all(16),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: _listenLoginStatus,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonArrowBack(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          "Log in",
                          style: GoogleFonts.comfortaa(fontSize: 36),
                        ),
                      ),
                      _buildEmailInput(),
                      SizedBox(height: 16),
                      _buildPasswordInput(),
                      SizedBox(height: 16),
                      _buildLoginButton()
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

  Widget _buildEmailInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          controller: _emailCtrl,
          focusNode: _emailFocus,
          autovalidateMode: AutovalidateMode.always,
          style: GoogleFonts.roboto(fontSize: 15),
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText: 'Email',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.red, width: 2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.red, width: 2))),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEmailChanged(email: value));
          },
          validator: (_) => _validateEmail(state),
          onEditingComplete: () {
            _emailFocus.unfocus();
            FocusScope.of(context).requestFocus(_passFocus);
          },
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: _passCtrl,
          focusNode: _passFocus,
          keyboardType: TextInputType.visiblePassword,
          autovalidateMode: AutovalidateMode.always,
          style: GoogleFonts.roboto(fontSize: 15),
          cursorColor: Colors.black,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.red, width: 2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.red, width: 2))),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
          validator: (_) => _validatePassword(state),
          onEditingComplete: () {
            _passFocus.unfocus();
            // if (state.status.isValidated) {
            //   context.read<LoginBloc>().add(LoginSubmitted());
            // }
          },
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SquareButton(
            onTap: () => _onLoginTapped(state, context),
            text: "LOG IN",
            btnColor:
                _validateLogin(state, context) ? Colors.black : Colors.black54,
            textStyle: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Colors.white));
      },
    );
  }
}
