import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart_laga/data/apis/getuserdata.dart';
import 'package:shart_laga/data/firebaseuser.dart';
import 'package:shart_laga/logic/cubits/user_cubit/user_cubit.dart';

import 'logic/cubits/user_cubit/user_state.dart';
import 'models/user.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Page'),
      ),
      body: Container(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                context.read<UserInfo>().emitUserStream();
              },
              color: Colors.amber,
              child: Text('Get Users'),
            ),
            BlocBuilder<UserInfo, UserState>(
              builder: (context, state) {
                if (state is UsersLoaded) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                        itemCount: state is UserLoaded ? state.users.length : 1,
                        itemBuilder: (context, index) {
                          return Text(
                            state.users[index].username.toString() +
                                ' ' +
                                state.users.length.toString(),
                            style: TextStyle(color: Colors.redAccent),
                          );
                        }),
                  );
                } else {
                  return Text(state.props.first.toString(),
                      style: TextStyle(color: Colors.amber));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
