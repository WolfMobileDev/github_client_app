import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/i10n/localization_intl.dart';
import 'package:github_client_app/models/index.dart';

class RepoItem extends StatefulWidget {
  final Repo repo;

  // 将`repo.id`作为RepoItem的默认key
    RepoItem(this.repo) : super(key : ValueKey(repo.id));

  @override
  State<StatefulWidget> createState() => _RepoItemState();

}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    var subTitle;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: gmAvatar(
                  //项目owner头像
                  widget.repo.owner.avatar_url,
                  width:24,
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  widget.repo.owner.login,
                  textScaleFactor: .9,
                ),
                subtitle: subTitle,
                trailing: Text(widget.repo.language ?? ""),
              ),
              // 构建项目标题和简介
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.repo.fork ? widget.repo.full_name : widget.repo.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: widget.repo.fork ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      child: widget.repo.description == null ? Text(
                        DemoLocalizations.of(context).title,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                      ) 
                      : Text(
                        widget.repo.description,
                        maxLines: 3,
                        style: TextStyle(
                          height: 1.15,
                          color: Colors.blueGrey[700],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 构建卡片底部信息
              _buildBottom()
            ],
          ),
        ),
      ),
    );
  }

  Widget gmAvatar(String url, {
    double width = 30,
    double height,
    BoxFit fit,
    BorderRadius borderRadius
  }) {
    var placeholder = Image.asset(
      "imgs/avatar-default.png", //头像占位图，加载过程中显示
      width: width,
      height: height
    );

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>placeholder,
        errorWidget: (context, url, error) =>placeholder,
      ),
    );
  }

  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 15
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,  
        ),
        child: Builder(
          builder: (context){
            var children = <Widget> [
              Icon(Icons.star),
              Text(" " + widget.repo.stargazers_count.toString().padRight(paddingWidth)),
              Icon(Icons.speaker_phone),
              Text(widget.repo.forks_count.toString().padRight(paddingWidth)),
            ];
            if(widget.repo.fork) {
              children.add(Text("Forked".padRight(paddingWidth)));
            }
            if(widget.repo.private == true) {
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(" private".padRight(paddingWidth)),
              ]);
            }
            return Row(children: children);
          }),
      ),
    );
  }
}