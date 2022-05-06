import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart_laga/logic/cubits/add_user_cubit/add_user_cubit.dart';
import 'package:shart_laga/logic/cubits/user_cubit/user_cubit.dart';
import 'package:shart_laga/userspage.dart';
import 'package:shart_laga/utils/colors.dart';
import 'data/firebaseuser.dart';
import 'logic/cubits/user_cubit/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserDetails(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserInfo(context.read<UserDetails>()),
            ),
            BlocProvider(
              create: (context) => AddUserCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.dark().copyWith(
                primaryColor: primaryColor,
                scaffoldBackgroundColor: scaffoldBgColor),
            home: MyHomePage(title: '\$hart'),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int a = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<UserInfo, UserState>(builder: (context, state) {
              if (state is UserLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            context.read<UserInfo>().emitUserStream();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UsersPage();
                            }));
                          },
                          child: Text(state.user.username.toString())),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(state.user.email.toString()),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: ListView.builder(
                                itemCount: state.user.bets.length,
                                itemBuilder: (context, pos) {
                                  final bets = state.user.bets[pos];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Bet ${pos + 1}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w700)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Title : ${bets.title}',
                                              style: TextStyle(
                                                  color: primaryColor),
                                            ),
                                            Text(bets.description),
                                            FittedBox(
                                              child: Text(
                                                  '${bets.challenger} vs ${bets.accepter}'),
                                            ),
                                            Text('Amount : ' +
                                                bets.amount.toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                      )
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              }
            }),
            MaterialButton(
              onPressed: () {
                //BlocProvider.of<AddUserCubit>(context).onBetAdd();
                BlocProvider.of<UserInfo>(context).getuserinfo();
              },
              color: primaryColor,
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
