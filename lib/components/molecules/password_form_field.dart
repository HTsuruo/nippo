import 'package:flutter/material.dart';
import 'package:nippo/theme.dart';

class PasswordFormField extends StatefulWidget {
  PasswordFormField({@required this.controller});

  final TextEditingController controller;

  @override
  _PasswordFormFieldState createState() =>
      _PasswordFormFieldState(controller: controller);
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  _PasswordFormFieldState({@required this.controller});

  final TextEditingController controller;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style:
          TextStyle(color: VIC.navy, fontSize: 15, fontWeight: FontWeight.bold),
      cursorColor: VIC.navy,
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
          icon: Icon(Icons.lock, size: 20, color: VIC.navy),
          contentPadding: const EdgeInsets.all(16),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: VIC.border),
            gapPadding: 0,
          ),
          hintText: 'パスワード',
          hintStyle: TextStyle(fontWeight: FontWeight.normal),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'パスワードを入力しましょう';
        }
        if (value.length < 8) {
          return '8文字以上必要です';
        }
        return null;
      },
    );
  }
}
