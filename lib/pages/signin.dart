import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nippo/components/atoms/app_logo.dart';
import 'package:nippo/components/atoms/signin_sns_btn.dart';
import 'package:nippo/constant.dart';
import 'package:nippo/pages/home.dart';
import 'package:nippo/pages/register.dart';
import 'package:nippo/pages/signin_email.dart';
import 'package:nippo/repositories/user_repository.dart';
import 'package:nippo/repositories/auth_repository.dart';
import 'package:nippo/states/progress_hub_state.dart';
import 'package:nippo/states/user_state.dart';
import 'package:nippo/theme.dart';
import 'package:provider/provider.dart';

@immutable
// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  static const String routeName = '/signin';
  static const double snsLogoHeight = 24;

  Image mailLogo = Image(
    image: ExactAssetImage(AssetPath.MAIL_LOGO_PATH),
    height: snsLogoHeight,
  );

  Image googleLogo = Image(
    image: ExactAssetImage(AssetPath.GOOGLE_LOGO_PATH),
    height: snsLogoHeight,
  );

  Future<void> signInWithGoogle({BuildContext context}) async {
    try {
      Provider.of<ProgressHUDState>(context, listen: false)
          .update(newState: true);
      final user = await Auth().signInWithGoogle();
      if (user != null) {
        await UserRepository().updateUser(user: user);
        Provider.of<UserController>(context, listen: false)
            .updateData(user: user);
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    } on Exception catch (e) {
      print(e);
    }
    Provider.of<ProgressHUDState>(context, listen: false)
        .update(newState: false);
  }

  void onClickSignInWithEmailBtn({BuildContext context}) {
    Navigator.push(
        context,
        MaterialPageRoute<MaterialPageRoute>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return SignInEmailPage();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressHUDState>(context).saving,
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Hero(
                child: AppLogo(height: 160),
                tag: 'appLogo',
              ),
              const SizedBox(
                height: 50,
              ),
              SignInSnsBtn(
                logoImg: googleLogo,
                label: 'Sign in with Google',
                onPressed: () async => signInWithGoogle(context: context),
              ),
              const SizedBox(
                height: 24,
              ),
              SignInSnsBtn(
                logoImg: mailLogo,
                label: 'Sign in with Email',
                onPressed: () => onClickSignInWithEmailBtn(context: context),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  child: Text('アカウント登録はこちら',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: VIC.navy))),
            ],
          ),
        ),
      )),
    );
  }
}
