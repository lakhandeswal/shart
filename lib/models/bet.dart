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

  // Bet.fromJson(Map json)
  //        :title = json['title'],
  //         description = json['description'],
  //         challenger = json['challenger'],
  //         accepter = json['accepter'],
  //         amount = json['amount']

  // tojson() {
  //   return {
  //       'title': this.title,
  //       'description': this.description,
  //       'challenger': this.challenger,
  //       'accepter': this.accepter,
  //       'amount': this.amount
  //     };
  //}
}
