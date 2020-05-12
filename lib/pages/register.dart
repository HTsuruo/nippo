import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nippo/models/user.dart';
import 'package:nippo/pages/home.dart';
import 'package:nippo/repositories/auth_repository.dart';
import 'package:nippo/repositories/user_repository.dart';
import 'package:nippo/states/progress_hub_state.dart';
import 'package:nippo/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:nippo/components/molecules/login_form_field.dart';
import 'package:nippo/components/molecules/password_form_field.dart';
import 'package:nippo/components/molecules/submit_btn.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final _controller = <String, TextEditingController>{
      'email': TextEditingController(),
      'password': TextEditingController(),
    };
    final _formKey = GlobalKey<FormState>();

    Future<Map<String, Object>> submit() async {
      final email = _controller['email'].text;
      final password = _controller['password'].text;
      return Auth().signUpWithEmail(email: email, password: password);
    }

    Future<void> onSuccess({User tmpUser}) async {
      final user = User(
          uid: tmpUser.uid,
          email: tmpUser.email,
          providerData: tmpUser.providerData,
          lastSignInTime: tmpUser.lastSignInTime);
      await UserRepository().updateUser(user: user);
      Provider.of<UserController>(context, listen: false)
          .updateData(user: user);
      await Navigator.pushReplacementNamed(context, HomePage.routeName);
      _controller['email'].dispose();
      _controller['password'].dispose();
    }

    void onFailed({BuildContext context, String errMessage}) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(errMessage),
          backgroundColor: Colors.red,
        ),
      );
    }

    return ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressHUDState>(context).saving,
      child: Scaffold(
        appBar: AppBar(title: const Text('メールアドレスで登録')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  EmailFormField(
                    controller: _controller['email'],
                  ),
                  const SizedBox(height: 16),
                  PasswordFormField(
                    controller: _controller['password'],
                  ),
                  const SizedBox(height: 16),
                  //SnackBar表示のためにcontextを生成.
                  Builder(
                    builder: (context) {
                      return SubmitBtn(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final map = await submit();
                            if (map['result'] as bool) {
                              await onSuccess(tmpUser: map['user'] as User);
                            } else {
                              final message = map['message'].toString();
                              onFailed(context: context, errMessage: message);
                            }
                          }
                        },
                        btnText: 'アカウント登録',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
