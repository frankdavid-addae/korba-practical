import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:korba_practical/constants.dart';
import 'package:korba_practical/models/auth_user_model.dart';
import 'package:korba_practical/models/users_model.dart';
import 'package:korba_practical/providers/auth_user_provider.dart';
import 'package:korba_practical/providers/users_provider.dart';
import 'package:korba_practical/route_generator.dart';
import 'package:korba_practical/screens/auth/sign_in_screen.dart';
import 'package:korba_practical/screens/home/home_screen.dart';
import 'package:korba_practical/services/get_it_service_locator.dart';
import 'package:korba_practical/services/shared_preference_store.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  setUpGetItServiceLocator();

  final _sharedPrefStore = GetIt.I.get<SharedPrefStore>();
  await _sharedPrefStore.reloadData();
  Map<String, dynamic>? authUserData =
      await _sharedPrefStore.retrieveDecodeData('authUserData');

  var isLoggedIn = (await _sharedPrefStore.retrieveStringData('token') == null)
      ? false
      : true;
  List? usersData =
      await _sharedPrefStore.retrieveDecodeDynamicData('usersData');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthUserProvider>(
          create: (context) =>
              AuthUserProvider(AuthUserModel.fromJson(authUserData!)),
          // AuthUserProvider(isLoggedIn ? UserModel.fromJson(userData!) : null),
        ),
        ChangeNotifierProvider<UsersProvider>(
          create: (context) =>
              UsersProvider(UsersModel.fromJson(usersData ?? [])),
        ),
      ],
      child: KorbaPracticalApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class KorbaPracticalApp extends StatelessWidget {
  const KorbaPracticalApp({Key? key, this.isLoggedIn}) : super(key: key);

  final bool? isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Korba Practical',
      theme: ThemeData(
        primaryColor: eerieBlackColor,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 350,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1200, name: TABLET),
        ],
      ),
      initialRoute: _initialRoute(isLoggedIn!),
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: RouteGenerator.navigatorKey,
    );
  }

  String _initialRoute(bool isLoggedIn) {
    String routeName;
    if (isLoggedIn) {
      routeName = HomeScreen.routeName;
    } else {
      routeName = SignInScreen.routeName;
    }
    return routeName;
  }
}
