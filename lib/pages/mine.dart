import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../actions/actions.dart';
import '../reducers/reducers.dart';
class MinePage extends StatefulWidget{
  @override
  MinePageState createState() => MinePageState();  
}
class MinePageState extends State<MinePage> {
  List infoList = [
    {
      'kye': 'msgCenter',
      'content': {
        'title': '消息中心',
        'icon':Icons.notifications,
        'color': Colors.blue,
        'path': '/msgCenter'
      }
    },
    {
      'kye': 'collectedEntriesCount',
      'content': {
        'title': '我喜欢的',
        'icon':Icons.favorite,
        'color': Colors.green,
        'path': '/like'
      }
    },
    {
      'kye': 'collectionSetCount',
      'content': {
        'title': '收藏集',
        'icon':Icons.collections,
        'color': Colors.blue,
        'path': '/collections'
      }
    },
    {
      'kye': 'postedEntriesCount',
      'content': {
        'title': '已购小册',
        'icon':Icons.shop,
        'color': Colors.orange,
        'path': '/myBooks'
      }
    },
    {
      'kye': 'collectionSetCount',
      'content': {
        'title': '我的钱包',
        'icon':Icons.account_balance_wallet,
        'color': Colors.blue,
        'path': '/myWallet'
      }
    },
    {
      'kye': 'likedPinCount',
      'content': {
        'title': '赞过的沸点',
        'icon':Icons.thumb_up,
        'color': Colors.green,
        'path': '/pined'
      }
    },
    {
      'kye': 'viewedEntriesCount',
      'content': {
        'title': '阅读过的文章',
        'icon':Icons.remove_red_eye,
        'color': Colors.grey,
        'path': '/read'
      }
    },
    {
      'kye': 'subscribedTagsCount',
      'content': {
        'title': '标签管理',
        'icon':Icons.picture_in_picture,
        'color': Colors.grey,
        'path': '/tags'
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<Map, Map>(
      converter: (store) => store.state,
      builder: (context, info) {
        Map userInfo = info;
        if (userInfo.isNotEmpty) {
          infoList.map((item){ item['content']['count']= userInfo['user'][item['key']]; }).toList();
        }
        return new Scaffold(
          appBar: new AppBar(title: new Text('我的'), centerTitle: true,backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),),
          body: new ListView(
            children: <Widget>[
              new StoreConnector<Map, Map>(
                converter: (store) => store.state,
                builder: (context, info) {
                  if(info.isNotEmpty){} else {}
                  return new  Container(
                    child: new ListTile(
                      leading: null,
                      title: info.isEmpty? new Text('listTitle'):new Text(''),
                      subtitle: info.isEmpty? new Container(width: 0.0,height: 0.0,): new Text('${info['user']['jobTitle']} @ ${info['user']['company']}'),
                      enabled: true,
                      trailing: new Icon(Icons.keyboard_arrow_right),
                      onTap: () { Navigator.pushNamed(context, '/signin');},                      
                    ),
                    padding: new EdgeInsets.only(top: 15.0, bottom: 15.0),
                    margin: new EdgeInsets.only(top:15.0,bottom: 15.0),
                    decoration: new BoxDecoration(
                      border: new Border(top: new BorderSide(width: 0.2,color: new Color.fromRGBO(215,217, 220 , 1.0)),bottom: new BorderSide(width: 0.2, color: new Color.fromRGBO(215, 217, 220, 1.0)) ),
                      color: Colors.white
                    ),                  
                  );
                },
              ),
              new Column(
                children: <Widget>[
                  new  Container(
                    margin: new EdgeInsets.only(top: 15.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                       border: new Border(bottom: new BorderSide(width: 0.2,color: new Color.fromRGBO(215,217, 220 , 1.0)))
                    ),
                    child: new ListTile(
                      leading: new Icon(Icons.insert_drive_file),
                      title: new Text('意见反馈'),
                      subtitle: new Container(width: 0.0, height: 0.0,),
                      trailing: new Icon(Icons.keyboard_arrow_right),
                      onTap: (){},
                    ),
                  )
                ],
              )

            ],
          )
        );
      },
    );
  }
}
