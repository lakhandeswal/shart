import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shart_laga/models/bet.dart';
import 'package:shart_laga/models/user.dart';

class UserDetails {
  static User user =
      User(username: 'jatindahiya', email: 'jatindahiya7@gmail.com', bets: [
    Bet('elon musk twitter deal', 'will elon musk buy twitter ?',
        'lakhandeswal', 'jatindahiya', 100),
    Bet('holiday at buaji\'s', 'will we be sent to buaji\'s after exam ?',
        'jatindahiya', 'navditadahia', 50)
  ]);

  static fetchuserdetails(String username) async {
    final String loadresponse =
        await rootBundle.loadString("lib/assets/data.json");
    final jsonResponse = jsonDecode(loadresponse);
    final usertoparse = jsonResponse['users'][username];
    final betdate = usertoparse['bets'][1];
    final bet = jsonResponse['bets'][username][betdate];
    List<Bet> allbets = [];
    if (bet.length > 0) {
      for (int i = 0; i < bet.length; i++) {
        Bet betn = Bet(bet[i]['title'], bet[i]['description'],
            bet[i]['challenger'], bet[i]['acceptor'], bet[i]['amount']);
        allbets.add(betn);
        usertoparse['bets'] = allbets;
      }
    } else {
      usertoparse['bets'] = [Bet('---', '---', '---', '---', 0)];
    }
    var response = await user.fromjson(usertoparse);
    print('awesome response, ${response.email}');
    return response;
  }
}
