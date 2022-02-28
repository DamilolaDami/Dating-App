// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiki/authentications_bloc/cubits/signup_cubit.dart';
import 'package:tiki/constatns/app_router.dart';
import 'package:tiki/models/user.dart';
import 'package:tiki/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tiki/pages/onboarding/onboardinng.dart';
import 'package:tiki/pages/tabs/mainpage.dart';
import 'package:tiki/providers/userdata.dart';
import 'package:tiki/respositories/bloc/image_bloc.dart';
import 'package:tiki/respositories/bloc/swipebloc_bloc.dart';
import 'package:tiki/respositories/databerepository.dart';
import 'package:tiki/respositories/mainauth.dart';
import 'pages/onboarding/onboardinng.dart';
import 'respositories/baseusers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<UserData>(create: (_) => UserData()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? status;
  void getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      status = prefs.getString('loggedIn');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginStatus();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => AuthRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignupCubit>(
            create: (_) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
            child: const OnboardingScreen(),
          ),
          BlocProvider(
            create: (_) => SwipeBloc(
              baseUsersRepo: Usersdata(),
            )..add(LoadedSwipe()),
          ),
          BlocProvider(
              create: (_) => ImageBloc(databaseRepository: DatabaseRepository())
                ..add(LoadImage())),
        ],
        child: MaterialApp(
          title: 'Discover',
          debugShowCheckedModeBanner: false,
          initialRoute: OnboardingScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
          theme: ThemeData(
              primarySwatch: Colors.red,
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              accentColor: Colors.red,
              primaryColorLight: Colors.red),
          home: OnboardingScreen(),
        ),
      ),
    );
  }
}

Future<auth.User> getcureentUser() async {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final auth.User user = _auth.currentUser!;
  return user;
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<auth.User>(
      future: getcureentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainPage();
        }
        return OnboardingScreen();
      },
    );
  }
}

// class AuthenticationWrapper extends StatefulWidget {
//   static const String routeName = '/wrapper';
//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: AuthenticationWrapper.routeName),
//       builder: (_) => AuthenticationWrapper(),
//     );
//   }

//   @override
//   State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
// }

// class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<auth.User>(
//         future: auth.FirebaseAuth.instance.currentUser! as Future<auth.User>,
//         builder: (BuildContext context, AsyncSnapshot<auth.User> snapshot) {
//           if (snapshot.hasData) {
//             auth.User? user = snapshot.data; // this is your user instance
//             /// is because there is user already logged
//             return HomePage();
//           }

//           /// other way there is no user logged.
//           return OnboardingScreen();
//         });
//   }
// }
