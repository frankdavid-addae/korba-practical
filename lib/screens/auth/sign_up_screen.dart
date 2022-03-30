import 'package:flutter/material.dart';
import 'package:korba_practical/constants.dart';
import 'package:korba_practical/screens/auth/sign_in_screen.dart';
import 'package:korba_practical/widgets/shared_widgets/custom_button.dart';
import 'package:korba_practical/widgets/shared_widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign-up-screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _keyLoader = GlobalKey<State>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool isHidden = true;
  bool btnLoginEnabled = true;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
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
                key: _signUpFormKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  children: [
                    CustomInputField(
                      hintText: 'Full Name',
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.person,
                          color: darkJungleGreenColor,
                          size: Constant.kSize(
                              mediaQueryHeight, 28.0, 26.0, 24.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Full Name field is required';
                        }
                        return null;
                      },
                    ),
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
                onPressed: () {},
                elevation: 2.0,
                text: 'SIGN UP',
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
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.routeName,
                  (route) => false,
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: smallTextStyle.copyWith(
                        color: darkJungleGreenColor,
                        fontSize:
                            Constant.kSize(mediaQueryHeight, 17.0, 16.0, 15.0),
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
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
    setState(() => btnLoginEnabled = state);
  }
}
