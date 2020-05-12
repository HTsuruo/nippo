import 'package:flutter/material.dart';
import 'package:nippo/models/user.dart';
import 'package:nippo/components/atoms/profile_circle_image.dart';

class ProfileArea extends StatelessWidget {
  const ProfileArea({@required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: ProfileCircleImage(
            imageUrl: user.photoUrl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            user.displayName ?? '名もなき人',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(user.email)),
      ],
    );
  }
}
