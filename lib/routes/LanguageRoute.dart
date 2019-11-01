import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/LocaleModel.dart';
import 'package:github_client_app/i10n/localization_intl.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localModel = Provider.of<LocaleModel>(context);
    var gm = DemoLocalizations.of(context);

    //构建语言选择项
    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          style: TextStyle(
            color: localModel.locale == value ? color : null,
          ),
        ),
        trailing: localModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          // 更新locale后MaterialApp会重新build
          localModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("中文"),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem("自动", null),
        ],
      ),
    );
  }
  
}