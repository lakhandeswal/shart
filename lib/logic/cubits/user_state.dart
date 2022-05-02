import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart_laga/models/user.dart';

abstract class UserState extends Equatable {
  UserState();
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  User user;

  UserLoaded({required this.user});

  @override
  List<Object?> get props => [this.user];
}
