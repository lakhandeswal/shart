import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shart_laga/data/firebaseuser.dart';
import '../../models/bet.dart';
import '../../models/user.dart';

class GetUser {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference bets = FirebaseFirestore.instance.collection('bets');

  Stream<List<User>> getUserStream() {
    print('steam data');
    return users.snapshots().map((snapShot) =>
        snapShot.docs.map((document) => User.fromjson(document)).toList());
  }

  Future getUserData(docId) async {
    final rawUserData = await users.doc(docId).get();
    return rawUserData;
  }

  Future getbets(docId) async {
    final Future<DocumentSnapshot<Object?>> rawBetData =
        bets.doc(docId).get().then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot;
    });
    return rawBetData;
  }

  late var cuid;
  Future addUserData(name, email) async {
    users.add({
      'name': name, // John Doe
      'email': email, // Stokes and Sons
      'bets': []
    }).then((value) {
      cuid = value.id;
      print("User Added");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  Future addbetData(title, description, challenger, accepter, amount) async {
    bets.add({
      'title': title,
      'description': description,
      'challenger': challenger,
      'accepter': accepter,
      'amount': amount
    }).then((value) async {
      final user = await getUserData('ftqsdOrweoYIexuKmOSr');
      List allbets = user['bets'];
      allbets.add(value.id.toString());
      users.doc('ftqsdOrweoYIexuKmOSr').update(
        {'bets': allbets},
      );
      allbets = [];
    }).catchError((error) {
      print('error while adding bet $error');
    });
  }
}
