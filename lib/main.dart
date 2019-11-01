import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/LocaleModel.dart';
import 'package:github_client_app/common/ThemeModel.dart';
import 'package:github_client_app/common/UserModel.dart';
import 'package:github_client_app/i10n/localization_intl.dart';
import 'package:github_client_app/routes/LanguageRoute.dart';
import 'package:github_client_app/routes/LoginRoute.dart';
import 'package:github_client_app/routes/ThemeChangeRoute.dart';
import 'package:github_client_app/routes/home_page.dart';
import 'package:provider/provider.dart';

//void main() => runApp(MyApp());

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: ThemeModel()),
          ChangeNotifierProvider.value(value: UserModel()),
          ChangeNotifierProvider.value(value: LocaleModel()),
        ],
        child: Consumer2<ThemeModel, LocaleModel>(
            builder: (BuildContext context, themeModel, localeModel, Widget child) {
              return MaterialApp(
                theme: ThemeData(
                  primarySwatch: themeModel.theme,
                ),
                onGenerateTitle: (context) {
                  return DemoLocalizations.of(context).title;
                },
                home: HomeRoute(),
                locale: localeModel.getLocale(),
                //我们只支持美国英语和中文简体
                supportedLocales: [
                  const Locale('en', 'US'), // 美国英语
                  const Locale('zh', 'CN'), // 中文简体
                ],
                localizationsDelegates: [
                  //本地化的代理类
                  DemoLocalizationsDelegate()
                ],
                localeResolutionCallback: (Locale _local, Iterable<Locale> supportedLocales) {
                  if(localeModel.getLocale() != null) {
                    //如果已经选定语言，则不跟随系统
                    return localeModel.getLocale();
                  } else {
                    Locale locale;

                    //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
                    //则默认使用美国英语
                    if(supportedLocales.contains(_local)) {
                      locale = _local;
                    } else {
                      locale = Locale('en', 'US');
                    }
                    return locale;
                  }
                },
                routes: <String, WidgetBuilder> {
                  "login": (context) => LoginRoute(),
                  "themes": (context) => ThemeChangeRoute(),
                  "language": (context) => LanguageRoute(),
                },
              );
            },
        ),
    );
  }
}
