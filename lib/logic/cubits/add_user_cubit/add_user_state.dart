part of 'add_user_cubit.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

class AddingUserData extends AddUserState {}

class AddedUserData extends AddUserState {}
