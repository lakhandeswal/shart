import 'package:shart_laga/models/bet.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final List bets;

  User({required this.username, required this.email, required this.bets});

  @override
  List<Object?> get props => [this.username, this.email, this.bets];

  static User fromjson(json) {
    User user =
        User(username: json['name'], email: json['email'], bets: json['bets']);
    return user;
  }

  tojson() =>
      {'username': this.username, 'email': this.email, 'bets': this.bets};
}
