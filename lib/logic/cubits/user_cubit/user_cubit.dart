import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart_laga/data/firebaseuser.dart';
import 'package:shart_laga/logic/cubits/user_cubit/user_state.dart';
import 'package:shart_laga/models/user.dart';

class UserInfo extends Cubit<UserState> {
  final UserDetails _userDetails;
  UserInfo(this._userDetails) : super(UserLoading()) {
    emitUserStream();
  }

  void getuserinfo() async {
    User user = await UserDetails.fetchuserdetails();
    print(user);
    emit(UserLoaded(user: user));
  }

  void emitUserStream() async {
    _userDetails.getUserStream().listen((users) {
      print('users are here ${users.length}');
      emit(UsersLoaded(users: users));
    });
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
