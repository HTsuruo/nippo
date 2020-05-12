import 'package:flutter/material.dart';
import 'package:nippo/theme.dart';
import 'package:email_validator/email_validator.dart';

class EmailFormField extends StatelessWidget {
  EmailFormField({@required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:
          TextStyle(color: VIC.navy, fontSize: 15, fontWeight: FontWeight.bold),
      cursorColor: VIC.navy,
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(Icons.email, size: 20, color: VIC.navy),
        contentPadding: const EdgeInsets.all(16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: VIC.border),
          gapPadding: 0,
        ),
        hintText: 'メールアドレス',
        hintStyle: TextStyle(fontWeight: FontWeight.normal),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'メールアドレスを入力しましょう';
        }
        if (!EmailValidator.validate(value)) {
          return '正しく入力して下さい';
        }
        return null;
      },
    );
  }
}
