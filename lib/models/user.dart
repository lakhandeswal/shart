import 'package:shart_laga/models/bet.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  String username;
  String email;
  List<Bet> bets;

  User({required this.username, required this.email, required this.bets});

  @override
  List<Object?> get props => [this.username, this.email, this.bets];

  fromjson(Map<String, dynamic> json) {
    print('json bets');
    print(json['bets']);
    return User(
        username: json['name'], email: json['email'], bets: json['bets']);
  }

  tojson() =>
      {'username': this.username, 'email': this.email, 'bets': this.bets};
}
