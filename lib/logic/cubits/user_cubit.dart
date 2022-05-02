import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart_laga/data/firebaseuser.dart';
import 'package:shart_laga/logic/cubits/user_state.dart';
import 'package:shart_laga/models/bet.dart';
import 'package:shart_laga/models/user.dart';

class UserInfo extends Cubit<UserState> {
  UserInfo() : super(UserLoading());

  void getuserinfo() async {
    User user = await UserDetails.fetchuserdetails('lakhandeswal');
    emit(UserLoaded(user: user));
  }

  void login() async {
    // emit(UserLoading());
    User user = await UserDetails.fetchuserdetails('navditadahiya');
    emit(UserLoaded(user: user));
  }
}
