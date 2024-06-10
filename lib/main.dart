import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_flutter/src/core/constants/color_constants.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/localization/language_constants.dart';
import 'package:kanban_flutter/src/routing/routing_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void mainDelegate() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /// BotToast Initialize
    final botToastBuilder = BotToastInit();

    /// System Orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp.router(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primary),
        useMaterial3: true,
      ),
      routerConfig: RoutingConfig.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
    );
  }
}
