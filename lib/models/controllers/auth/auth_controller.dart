import 'package:nippo/models/controllers/auth/auth_state.dart';
import 'package:nippo/models/repositories/auth_repository.dart';
import 'package:nippo/models/repositories/post_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class AuthController extends StateNotifier<AuthState> with LocatorMixin {
  AuthController() : super(AuthState(user: null, posts: []));

  @override
  Future<void> initState() async {
    // TODO(tsuruoka): implement initState
    print('AuthController -> initState');
    if (await AuthRepository().isLogin()) {
      final currentUser = await AuthRepository().currentUser();
      state = AuthState(
        user: currentUser,
        posts: await PostRepository().fetchByUser(uid: currentUser.uid),
      );
    }
  }
}
