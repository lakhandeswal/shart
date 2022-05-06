import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shart_laga/models/bet.dart';
import 'package:shart_laga/models/user.dart';
import 'apis/getuserdata.dart';

// to load data from local json file
// final String loadresponse =
//     await rootBundle.loadString("lib/assets/data.json");
// final jsonResponse = jsonDecode(loadresponse);
// final usertoparse = jsonResponse['users'][username];
//final betdate = usertoparse['bets'][1];

class UserDetails {
  static fetchuserdetails() async {
    GetUser getuser = GetUser();
    final jsondata = await getuser.getUserData("ftqsdOrweoYIexuKmOSr");
    final bet = jsondata['bets'];
    List allBets = [];
    if (bet.length > 0) {
      for (int i = 0; i < bet.length; i++) {
        final betData = await getuser.getbets(bet[i]);
        Bet betN = Bet.fromjson(betData);
        allBets.add(betN);
      }
    }
    final jsonRes = {
      'name': jsondata['name'],
      'email': jsondata['email'],
      'bets': allBets,
    };

    var response = User.fromjson(jsonRes);
    return response;
  }

  static addUser() async {
    GetUser getuser = GetUser();
    final jsondata =
        await getuser.addUserData('pankajdeswal', 'pankajdeswal123@gmail.com');
    return jsondata;
  }

  static addbet() {
    GetUser getuser = GetUser();
    getuser.addbetData('code app', 'will i be able to code app b4 1 june',
        'lakhandeswal', 'pankajdeswal', 250);
  }

  // Stream<List<User>> getUserStream() {
  //   GetUser getuser = GetUser();
  //   Stream<List<User>> userlist = getuser.getUserStream();
  //   return userlist;
  // }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Stream<List<User>> getUserStream() {
    Stream<List<User>> userS =
        users.snapshots().map((snapShot) => snapShot.docs.map((document) {
              return User.fromjson(document);
            }).toList());
    print('getting or fetching users');
    return userS;
  }
}
