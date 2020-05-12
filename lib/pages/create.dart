import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nippo/models/post.dart';
import 'package:nippo/repositories/post_repository.dart';
import 'package:nippo/states/progress_hub_state.dart';
import 'package:nippo/states/user_state.dart';
import 'package:nippo/theme.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  static const String routeName = '/create';
  final _formKey = GlobalKey<FormState>();
  final _formController = {
    'title': TextEditingController(),
    'description': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressHUDState>(context).saving,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                padding: const EdgeInsets.all(0),
                child: const Text(
                  'キャンセル',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              SubmitBtn(formKey: _formKey, controller: _formController),
            ],
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 16,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputTitleForm(controller: _formController['title']),
                  const SizedBox(height: 16),
                  InputDescriptionForm(
                      controller: _formController['description']),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class InputTitleForm extends StatelessWidget {
  InputTitleForm({this.controller});
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next, // return押下時の処理を変更できる.
      controller: controller,
      maxLines: 1,
      autofocus: true,
      cursorColor: VIC.red,
      style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: .5),
      decoration: const InputDecoration(
        hintText: '今日を一言で表現すると？',
        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: VIC.red),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'テキストを入力しましょう';
        }
        return null;
      },
    );
  }
}

class InputDescriptionForm extends StatelessWidget {
  InputDescriptionForm({this.controller});
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 8,
      autofocus: true,
      cursorColor: VIC.red,
      decoration: const InputDecoration(
        filled: true,
        border: InputBorder.none,
        alignLabelWithHint: true,
        hintText: '今日起きたたくさんの出来事を記録しましょう',
        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'テキストを入力しましょう';
        }
        return null;
      },
    );
  }
}

class SubmitBtn extends StatelessWidget {
  const SubmitBtn({@required this.formKey, this.controller});

  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controller;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: VIC.red,
      onPressed: () async {
        if (formKey.currentState.validate()) {
          Provider.of<ProgressHUDState>(context, listen: false)
              .update(newState: true);
          await submit(controller, context);
          Navigator.pop(context);
          Provider.of<ProgressHUDState>(context, listen: false)
              .update(newState: false);
          controller['title'].dispose();
          controller['description'].dispose();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          '投稿する',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}

Future<void> submit(
    Map<String, TextEditingController> controller, BuildContext context) async {
  final post = Post(
      title: controller['title'].text,
      description: controller['description'].text);
  print('input: ${post.title}, ${post.description}');
  await PostRepository().createPost(
      post: post, uid: Provider.of<UserState>(context, listen: false).user.uid);
}
