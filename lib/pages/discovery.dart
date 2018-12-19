import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/httpHeaders.dart';
import 'dart:convert';
import 'dart:async';

class DiscoveryPage extends StatefulWidget{
  @override
  DiscoveryPageState createState()=> DiscoveryPageState();
}
class DiscoveryPageState extends State<DiscoveryPage>{
  List hotArticles;
  Future getHotArticles() async {
    return http.get(Uri.encodeFull(
      'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=${httpHeaders['X-Juejin-Src']}&uid=${httpHeaders['X-Juejin-Uid']}&device_id=${httpHeaders['X-Juejin-Client']}&token=${httpHeaders['X-Juejin-Token']}&limit=20&category=all&recomment=1'
    ));
  }
  @override
  void initState() {
    super.initState();
    this.getHotArticles().then((response) {
      setState((){
        hotArticles = json.decode(response.body)['d']['entrylist'];
      });
    }, onError: (e) {
      throw Exception('faild to load data');
    });
  }

  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          pinned:true,//appbar不消失
          title: new Card(
            color: new Color.fromRGBO(250,250,250,0.6),
            child: new FlatButton(
              onPressed:() { Navigator.pushNamed(context,'/search');},
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  new Icon(Icons.search,color: Colors.black),
                  new Padding(padding: new EdgeInsets.only(right: 5.0)),
                  new Text('搜索')
                ]
              )
            )
          ),
          titleSpacing: 5.0,          
          backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0)
        ),
        new SliverList(
          delegate: new SliverChildBuilderDelegate((context,index){
            return new Container(
              color: Colors.white,
              padding: new EdgeInsets.only(top: 15.0,bottom: 15.0),
              margin: new EdgeInsets.only(bottom: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(onPressed: null,child: new Column( children: <Widget>[new Icon(Icons.whatshot,color: Colors.red,size: 30.0),new Text('本周最热')],),),
                  new FlatButton(onPressed: null,child: new Column( children: <Widget>[new Icon(Icons.collections,color: Colors.green,size: 30.0),new Text('收藏集')],),),
                  new FlatButton(onPressed: () { Navigator.pushNamed(context, '/activities');},child: new Column( children: <Widget>[new Icon(Icons.toys,color: Colors.yellow,size: 30.0),new Text('活动')],),)
                ],
              ),
            );
          },childCount: 1)          
        ),
        new SliverList(
          delegate: new SliverChildBuilderDelegate((context,index){
            return new Container(
              padding: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                border: new Border(bottom: new BorderSide(width: 0.2, color: Colors.grey)),
                color: Colors.white
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    //mainAxisAlignment: MainAxisAlignment.start,//主轴靠左
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.whatshot,color: Colors.red),
                      new Padding(padding: new EdgeInsets.only(right: 5.0),),
                      new Text('热门文章',style: new TextStyle(fontSize: 14.0),)
                    ],
                  ),
                  new Row(
                    //mainAxisAlignment: MainAxisAlignment.start,//主轴靠左
                    children: <Widget>[
                      new Icon(Icons.settings,color: Colors.grey,),
                      new Padding(padding: new EdgeInsets.only(right: 5.0),),
                      new Text('定制热门',style: new TextStyle(fontSize: 14.0,color: Colors.grey),)
                    ],
                  )                
                ],
              ),
            );
          },childCount: 1),
        ),
        new SliverFixedExtentList(
          itemExtent: 100.0,
          delegate: new SliverChildBuilderDelegate((context,index){
            var itemInfo=hotArticles[index];
            return createItem(itemInfo);
          },childCount: hotArticles==null?0:hotArticles.length),
        )
      ],

    );
  }
}
