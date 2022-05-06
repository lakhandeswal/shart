import 'package:equatable/equatable.dart';
import 'package:shart_laga/models/user.dart';

class Bet extends Equatable {
  final String title;
  final String description;
  final String challenger;
  final String accepter;
  final int amount;

  Bet(this.title, this.description, this.challenger, this.accepter,
      this.amount);

  @override
  List<Object?> get props => [
        this.title,
        this.description,
        this.challenger,
        this.accepter,
        this.amount
      ];

  static fromjson(json) {
    return Bet(json['title'], json['description'], json['challenger'],
        json['accepter'], json['amount']);
  }

  tojson() {
    return {
      'title': this.title,
      'description': this.description,
      'challenger': this.challenger,
      'accepter': this.accepter,
      'amount': this.amount
    };
  }
}
