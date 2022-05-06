import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shart_laga/data/firebaseuser.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddingUserData());

  onAddUser() {
    emit(AddingUserData());
    UserDetails.addUser();
    print('user added add_user_cubit');
    emit(AddedUserData());
  }

  onBetAdd() {
    emit(AddingUserData());
    UserDetails.addbet();
    print('bet for user has been added jsonbet');
    emit(AddedUserData());
  }
}
