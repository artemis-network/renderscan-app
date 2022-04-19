import 'package:flutter/material.dart';

// components
import 'package:renderscan/common/components/form/rounded_input.dart';
import 'package:renderscan/common/components/form/rounded_button.dart';
import 'package:renderscan/common/components/form/rounded_password.dart';
import 'package:renderscan/common/components/form/already_have_account.dart';

// validations
import 'package:renderscan/screen/signup/signup_validations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  validation: SignupValidations().nameValidations,
                  hintText: "Name",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  validation: SignupValidations().emailValidations,
                  hintText: "Email",
                  icon: Icons.email,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  validation: SignupValidations().usernameValidations,
                  hintText: "Username",
                  icon: Icons.person_add_alt,
                  onChanged: (value) {},
                ),
                // RoundedPasswordField(
                //   text: "Password",
                //   onChanged: (value) {},
                // ),
                // RoundedPasswordField(
                //   text: "Confirm Password",
                //   onChanged: (value) {},
                // ),
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
                          return const SignUpScreen();
                          // return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
