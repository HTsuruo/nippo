import 'package:flutter/material.dart';
import 'package:nippo/constant.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({@required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: ExactAssetImage(AssetPath.APP_LOGO_PATH),
      height: height,
      alignment: FractionalOffset.center,
    );
  }
}
