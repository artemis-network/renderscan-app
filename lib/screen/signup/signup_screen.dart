import 'package:flutter/material.dart';

// components
import 'package:renderscan/common/components/form/rounded_input.dart';
import 'package:renderscan/common/components/form/rounded_button.dart';
import 'package:renderscan/common/components/form/rounded_password.dart';
import 'package:renderscan/common/components/form/already_have_account.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/login/login_screen.dart';

// validations
import 'package:renderscan/screen/signup/signup_validations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      validator: SignupValidations().nameValidations,
                      icon: Icons.person,
                      labelText: "Name",
                      hintText: "Name",
                    ),
                    CustomTextField(
                      validator: SignupValidations().emailValidations,
                      icon: Icons.email,
                      labelText: "Email",
                      hintText: "xyz@email.com",
                    ),
                    CustomTextField(
                      validator: SignupValidations().usernameValidations,
                      icon: Icons.person_add_alt_1,
                      labelText: "Username",
                      hintText: "xyz123",
                    ),
                    RoundedPasswordField(
                      validation: SignupValidations().passwordValidation,
                      text: "Password",
                      onChanged: (value) {},
                    ),
                    RoundedButton(
                      text: "SIGNUP",
                      press: () {
                        var errors = formkey.currentState!.validate();
                        print(errors);
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                              // return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -100,
            left: -100,
            child: Image.asset(
              "assets/images/gradient_one.png",
              width: size.width * 0.55,
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Image.asset(
              "assets/images/gradient_two.png",
              width: size.width * 0.5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  String hintText;
  String labelText;
  IconData icon;
  Function validator;

  CustomTextField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.icon,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        validator: (value) => validator(value),
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder()),
      ),
    );
  }
}
