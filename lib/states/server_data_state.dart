import 'package:flutter/cupertino.dart';
import 'package:nippo/repositories/user_repository.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class ServerDataState {
  const ServerDataState({this.users});
  final Stream<QuerySnapshot> users;
}

class ServerDataController extends StateNotifier<ServerDataState>
    with LocatorMixin {
  ServerDataController() : super(const ServerDataState());
  UserRepository get userRepository => read<UserRepository>();

  @override
  void initState() {
    super.initState();
    fetchUserAll();
  }

  void fetchUserAll() {
    print('ServerDataController -> UserRepository');
    state = ServerDataState(
      users: userRepository.fetchAllSnapshot(),
    );
  }
}
