import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../actions/actions.dart';
import '../reducers/reducers.dart';
class SignInPage extends StatefulWidget{
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
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
                  child: new ClipRRect(borderRadius: new BorderRadius.circular(15.0),child: new Image.asset('assets/img/logo.png'),),
                )
              ],
            )
          ]
          ,
        ),
      ),
    );
  }
}