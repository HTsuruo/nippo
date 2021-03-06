import 'package:flutter/material.dart';
import 'package:nippo/components/post_list_view_by_user.dart';
import 'package:nippo/components/profile_area.dart';
import 'package:nippo/models/controllers/auth/auth_state.dart';
import 'package:nippo/pages/setting/setting_page.dart';
import 'package:provider/provider.dart';

@immutable
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      Navigator.pushNamed(context, SettingPage.routeName);
                    },
                  ),
                ),
              ),
              const SyncArea(),
            ],
          ),
        ),
      ),
    );
  }
}

class SyncArea extends StatelessWidget {
  const SyncArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.select((AuthState s) => s);
    if (auth.user != null) {
      return Expanded(
        child: Column(
          children: <Widget>[
            ProfileArea(user: auth.user),
            PostListViewByUser(
              posts: auth.posts,
              user: auth.user,
            )
          ],
        ),
      );
    }
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
