import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/home/home_screen.dart';
import 'package:renderscan/screen/login/log_api.dart';

class GoogleLoginButton extends StatefulWidget {
  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    bool _isElevated = true;
    GoogleSignIn _googleSignin = GoogleSignIn();

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.2, 0, size.width * 0.2, 0),
      child: GestureDetector(
        child: AnimatedContainer(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: kprimaryAuthBGColor,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 2,
                    color: kprimaryNeuLight,
                    offset: Offset(-1, -1)),
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 8,
                    color: kprimaryNeuDark,
                    offset: Offset(5, 5)),
              ]),
          duration: Duration(milliseconds: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google-plus.png",
                height: 26,
                width: 26,
              ),
              Image.asset(
                "assets/images/google.png",
                height: 42,
                width: 70,
              )
            ],
          ),
        ),
        onTapUp: (tu) {
          setState(() {
            _isElevated = !_isElevated;
          });
        },
        onTapDown: (td) {
          setState(() {
            _isElevated = !_isElevated;
          });

          _googleSignin.signIn().then((user) {
            user = user as GoogleSignInAccount;
            log.i(user.displayName);
            LoginApi().googleLogin(user.email).then((value) {
              bool error = value.error ?? false;
              if (!error) {
                Storage().createSession(value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ),
                );
              }
            }).catchError((err) {
              print(err);
              log.e(">> Error");
              log.e(err);
            });
          }).catchError((err) {
            log.e(">> ERROR");
            log.e(err);
          });
        },
      ),
    );
  }
}
