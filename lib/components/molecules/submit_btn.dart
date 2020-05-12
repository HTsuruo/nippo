import 'package:flutter/material.dart';
import 'package:nippo/theme.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn({@required this.onPressed, @required this.btnText});
  final Function() onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: VIC.navy,
        child: Text(btnText,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        onPressed: onPressed,
      ),
    );
  }
}
