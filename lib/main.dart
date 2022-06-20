import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:framework/utils/device_util.dart';
import 'package:framework/utils/router_manager.dart';
import 'package:framework/utils/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:x_bank/resources/s_colors.dart';

import 'activitys/splash_activity.dart';
import 'configs/app_config.dart';
import 'controllers/extra/application_controller.dart';
import 'generated/l10n.dart';

//flutter version 2.5.3
//flutter build apk --no-tree-shake-icons --no-sound-null-safety    (if flutter is 1.20 or 1.21)
//flutter run --no-sound-null-safety
//flutter run -d chrome --no-sound-null-safety
//flutter build web --no-tree-shake-icons --no-sound-null-safety

void main() {
  if (DeviceUtil.isAndroid()) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApplicationController())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(
      theme: ThemeData(
          primaryColor: SColors.primary, backgroundColor: SColors.main_help),
      home: SplashActivity(),
      debugShowCheckedModeBanner: false,
      navigatorKey: AppConfig.navigatorStateKey,
      onGenerateRoute: RouterManager().router.generator,
      navigatorObservers: [RouterManager().routeRecorder],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
    return FutureBuilder<bool>(
      future: AppConfig.initBase(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return ScreenUtil.buildScreenChangeRefreshWidget(
              AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.dark, child: materialApp),
              (bool isPortrait, double width, double height) {
            setState(() {});
          });
        } else {
          return Container();
        }
      },
    );
  }
}
