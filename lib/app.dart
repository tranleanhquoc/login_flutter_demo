import 'package:example/commons/app_bloc_observer.dart';
import 'package:example/routes/locator.dart';
import 'package:example/routes/navigator_service.dart';
import 'package:example/routes/routes_generator.dart';
import 'package:example/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'commons/app_dimension.dart';
import 'data/repository/authentication_repository.dart';
import 'screens/authentication/bloc/bloc.dart';

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (_) => authenticationRepository)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
              ),
            )
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    setupLocators();
    // Show log flutter bloc
    Bloc.observer = AppBlocObserver();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('vi', 'VN'),
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'vi', countryCode: 'VN'),
        const Locale.fromSubtags(languageCode: 'en', countryCode: 'EN'),
      ],
      builder: (context, child) {
        final appDimension = AppDimension(context);
        appDimension.width = MediaQuery.of(context).size.width;
        appDimension.height = MediaQuery.of(context).size.height;
        return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  locator<NavigatorService>()
                      .pushNamedAndRemoveUntil(RoutesName.dashboard);
                  break;
                case AuthenticationStatus.unauthenticated:
                  locator<NavigatorService>()
                      .pushNamedAndRemoveUntil(RoutesName.authen);
                  break;
                default:
                  break;
              }
            },
            child: MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            ));
      },
      navigatorKey: locator<NavigatorService>().navigatorKey,
      initialRoute: RoutesName.authen,
      onGenerateRoute: RoutesGenerator().generateRoute,
      onUnknownRoute: RoutesGenerator().unknownRoute,
    );
  }
}
