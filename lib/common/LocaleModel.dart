import 'package:flutter/cupertino.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if(profile.locale == null) return null;
    var t = profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => profile.locale;

  //获取当前Locale的字符串表示
  set locale(String locale) {
    if(locale != profile.locale) {
      profile.locale = locale;
      notifyListeners();
    }
  }
}