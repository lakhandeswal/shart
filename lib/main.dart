import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart_laga/logic/cubits/user_cubit.dart';
import 'package:shart_laga/utils/colors.dart';
import 'logic/cubits/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserInfo(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
              primaryColor: primaryColor,
              scaffoldBackgroundColor: scaffoldBgColor),
          home: MyHomePage(title: '\$hart'),
        ));
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
                      Text(state.user.username.toString()),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(state.user.email.toString()),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                                itemCount: state.user.bets.length,
                                itemBuilder: (context, pos) {
                                  final bets = state.user.bets[pos];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Bet ${pos + 1}',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(bets.title),
                                            Text(bets.description),
                                            Text(bets.challenger),
                                            Text(bets.accepter),
                                            Text(bets.amount.toString())
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
                setState(() {
                  a = a + 1;
                });
                print(a);
                if (a % 2 == 0) {
                  print('getting user info');
                  BlocProvider.of<UserInfo>(context).getuserinfo();
                } else {
                  print('trying to login');
                  BlocProvider.of<UserInfo>(context).login();
                }
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
