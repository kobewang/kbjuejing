import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import '../actions/actions.dart';
import '../reducers/reducers.dart';
class SignInPage extends StatefulWidget{
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  String account;
  String password;
  Map userInfo;
  final TextEditingController accountController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  List signMethonds = [
    'lib/assets/img/weibo.png',
    'lib/assets/img/wechat.png',
    'lib/assets/img/github.png'
  ];
  void showAlert(String value) {
    showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(content: new Text(value));
      }
    );
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
        leading: new IconButton(icon: new Icon(Icons.chevron_left),onPressed: ((){Navigator.pop(context);}),),
        title: new Text('登录'),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  height: 80.0,
                  margin: new EdgeInsets.only(top: 30.0,bottom: 30.0),  
                  child: new Image.asset('lib/assets/img/logo.png'),                
                ),
                new Container(
                  decoration: new BoxDecoration(border:  new Border(top: new BorderSide(width: 0.5, color: Colors.grey),bottom: new BorderSide(width: 0.5,color: Colors.grey))),
                  margin: new EdgeInsets.only(bottom: 20.0),
                  child: new Column(
                    children: <Widget>[
                      new TextField(
                        decoration: new InputDecoration(hintText: '邮箱/手机', border: new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.grey,width: 0.2)),prefixIcon: new Padding(padding: new EdgeInsets.only(right: 20.0))),
                        controller: accountController,
                        onChanged: (String content) { setState(() {account = content;});},
                      ),
                      new TextField(
                        decoration:  new InputDecoration(hintText: '密码',border: InputBorder.none,prefixIcon: new Padding(padding: new EdgeInsets.only(right: 20.0),)),
                        controller: passwordController,
                        onChanged: (String content){ setState(() {password = content;}); },
                      )
                    ],
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Column(
                    children: <Widget>[
                      new StoreConnector<Map,VoidCallback>(
                        converter: (store) {
                          return () => store.dispatch(UserInfo('SETUSERINFO',userInfo));
                        },
                        builder: (context, callback) {
                          return new Card(
                            color: Colors.blue,
                            child: new FlatButton(
                              onPressed: (){
                                if (account == null) {
                                  showAlert('请输入账号');
                                } else if (password == null) {
                                  showAlert('请输入密码');
                                } else {
                                  String url ="https://juejin.im/auth/type/phoneNumber";
                                  http.post(url,body:{"phoneNumber": account, "password": password})
                                  .then((response){
                                    if(response.statusCode == 200) {
                                      userInfo = json.decode(response.body);callback();Navigator.pop(context);                                      ;
                                    }
                                  });
                                }
                              },
                              child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[new Text('登录', style: new TextStyle(color: Colors.white))],),
                            ),
                          ); 
                        },
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new FlatButton(
                            onPressed: () {},
                            child: new Text('忘记密码',style: new TextStyle(color:Colors.grey)),
                          ),
                          new FlatButton(
                            onPressed: () {},
                            child: new Text('注册账号',style:new TextStyle(color: Colors.grey)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Text('其他登录方式'),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: signMethonds.map((item) {
                          return new IconButton(icon: new Image.asset(item,color:Colors.blue), onPressed: null);
                        }).toList(),
                      ),
                      new Text('掘金 - juejin.im',style: new TextStyle(color: Colors.grey, fontSize: 12.0)),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new  Icon(Icons.check_circle,color: Colors.grey,size: 14.0,),
                          new Text('我已阅读同意',style: new TextStyle(color: Colors.grey,fontSize: 12.0),),
                          new FlatButton(onPressed: null, child: new Text('软件许可服务协议',style: new TextStyle(decoration: TextDecoration.underline,decorationColor: const Color(0xff000000),fontSize: 12.0),))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ]
          ,
        ),
      ),
    );
  }
}