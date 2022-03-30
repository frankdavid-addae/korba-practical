import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:korba_practical/classes/feedback_dialogs.dart';
import 'package:korba_practical/constants.dart';
import 'package:korba_practical/helpers.dart';
import 'package:korba_practical/screens/auth/sign_up_screen.dart';
import 'package:korba_practical/screens/home/home_screen.dart';
import 'package:korba_practical/services/auth_api_requests.dart';
import 'package:korba_practical/widgets/shared_widgets/custom_button.dart';
import 'package:korba_practical/widgets/shared_widgets/custom_input_field.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'sign-in-screen';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final _keyLoader = GlobalKey<State>();
  final _authApiRequest = GetIt.I.get<AuthApiRequest>();
  final _feedbackDialog = GetIt.I.get<FeedbackDialog>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool isHidden = true;
  bool btnSignInEnabled = true;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: silverSandColor,
      body: Container(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        padding: leftAndRightScreenPadding,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 30.0 * mediaQueryHeight * multiplier,
          ),
          child: Column(
            children: [
              SizedBox(height: mediaQueryHeight * 0.1),
              SizedBox(
                height: mediaQueryHeight * 0.15,
                width: mediaQueryWidth * 0.5,
                child: const Placeholder(),
                // Image.asset(
                //   'assets/images/sage_logo.png',
                //   fit: BoxFit.contain,
                // ),
              ),
              SizedBox(
                height: Constant.kSize(mediaQueryHeight, 100.0, 110.0, 100.0),
              ),
              // Sign In Form
              Form(
                key: _signInFormKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  children: [
                    CustomInputField(
                      hintText: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.email,
                          color: darkJungleGreenColor,
                          size: Constant.kSize(
                              mediaQueryHeight, 28.0, 26.0, 24.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email address field is required';
                        }
                        return null;
                      },
                    ),
                    CustomInputField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: isHidden,
                      keyboardType: TextInputType.visiblePassword,
                      fillColor: whiteColor,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          isHidden = !isHidden;
                        }),
                        icon: isHidden
                            ? Icon(
                                Icons.visibility,
                                size: Constant.kSize(
                                    mediaQueryHeight, 28.0, 26.0, 24.0),
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: Constant.kSize(
                                    mediaQueryHeight, 28.0, 26.0, 24.0),
                              ),
                        color: darkJungleGreenColor,
                        splashColor: Colors.transparent,
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password field is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Constant.kSize(mediaQueryHeight, 20.0, 30.0, 40.0),
              ),
              CustomButton(
                onPressed: btnSignInEnabled
                    ? () async {
                        if (_signInFormKey.currentState!.validate()) {
                          _toggleButtonState(false);
                          _feedbackDialog.loadingDialog(context, _keyLoader);

                          if (await ConnectivityWrapper.instance.isConnected) {
                            var input = {
                              "email": _emailController.text,
                              "password": _passwordController.text,
                              "push_notification_token": "token_goes_here",
                            };

                            var result =
                                await _authApiRequest.signIn(context, input);
                            if (result == 'success') {
                              Navigator.of(
                                _keyLoader.currentContext!,
                                rootNavigator: true,
                              ).pop();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (route) => false,
                              );
                              _toggleButtonState(true);
                            } else {
                              await Future.delayed(
                                Duration(milliseconds: Helpers.milliSeconds),
                              );
                              Navigator.of(
                                _keyLoader.currentContext!,
                                rootNavigator: true,
                              ).pop();
                              _feedbackDialog.errorDialog(
                                context,
                                result.toString(),
                              );
                              _toggleButtonState(true);
                            }
                          } else {
                            await Future.delayed(
                              Duration(milliseconds: Helpers.milliSeconds),
                            );
                            Navigator.of(
                              _keyLoader.currentContext!,
                              rootNavigator: true,
                            ).pop();
                            _feedbackDialog.internetError(context);
                            _toggleButtonState(true);
                          }
                        } else {
                          setState(() => _autoValidate =
                              AutovalidateMode.onUserInteraction);
                        }
                      }
                    : () {},
                elevation: 2.0,
                text: 'SIGN IN',
                color: darkJungleGreenColor,
                textStyle: smallTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: Constant.kSize(mediaQueryHeight, 17.0, 16.0, 15.0),
                ),
                height: Constant.kSize(mediaQueryHeight, 70.0, 65.0, 60.0),
              ),
              SizedBox(
                height: Constant.kSize(mediaQueryHeight, 45.0, 40.0, 30.0),
              ),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    'Forgot Password?',
                    style: smallTextStyle.copyWith(
                      color: darkJungleGreenColor,
                      fontSize:
                          Constant.kSize(mediaQueryHeight, 17.0, 16.0, 15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Constant.kSize(mediaQueryHeight, 40.0, 40.0, 30.0),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignUpScreen.routeName,
                  (route) => false,
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: smallTextStyle.copyWith(
                        color: darkJungleGreenColor,
                        fontSize:
                            Constant.kSize(mediaQueryHeight, 17.0, 16.0, 15.0),
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: smallTextStyle.copyWith(
                            color: graniteGrayColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Constant.kSize(
                                mediaQueryHeight, 17.0, 16.0, 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleButtonState(bool state) {
    setState(() => btnSignInEnabled = state);
  }
}
