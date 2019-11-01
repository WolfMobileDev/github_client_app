import 'package:flutter/cupertino.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    Global.saveProfile(); //保存Profile变更

    super.notifyListeners(); //通知依赖的Widget更新
  }
}