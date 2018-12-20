import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';
class ActivitiesPage extends StatefulWidget{
  @override
  ActivitiesPageState createState()=> new  ActivitiesPageState();
}
class ActivitiesPageState extends State<ActivitiesPage> {
  Future getCities() {
    Dio dio=new Dio();
    return  dio.get(Uri.encodeFull('https://event-storage-api-ms.juejin.im/v1/getCityList?uid=&client_id=&token=&src=web'));
  }
  @override
  Widget build(BuildContext context){
    return new FutureBuilder(
      future: getCities(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          var tabList=snapshot.data['d'];
          return new CreatePage(tabList:tabList);
        } else if (snapshot.hasError) {
          return Text('error:${snapshot.error}');
        }
        return new Container(
          color: new Color.fromRGBO(244, 245, 245, 1.0),
          child: new CupertinoActivityIndicator(),//ios加载光环
        );
      },
    );
  }
}
class CreatePage extends StatefulWidget{
  List tabList;
  @override
  CreatePage({Key key,this.tabList}):super(key:key);
  @override
  CreatePageState createState() => new  CreatePageState();
}
class CreatePageState extends State<CreatePage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: widget.tabList.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
          leading: new IconButton(icon: new Icon(Icons.chevron_left), onPressed: (){ Navigator.pop(context);},),
          title: new Text('活动', style: new TextStyle(color: Colors.black),),
          centerTitle: true,
          bottom:  new TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: widget.tabList.map((tab) { return new Tab(text: tab['cityName']);}).toList()
          ),
        ),
        body: new TabBarView(
          children: widget.tabList.map((cate) {return ActivitiesLists(categories: cate); }).toList()
        ),
      ),
    );
  }
}
class ActivitiesLists extends StatefulWidget {
  final Map categories;
  @override
  ActivitiesLists({Key key,this.categories}):super(key: key);
  ActivitiesListsState createState()=> new ActivitiesListsState();
}
class ActivitiesListsState extends State<ActivitiesLists> {
  List activitiesList;
  Future getActivities({int pageSize =20, int pageNum=1,String cityAlias = '', String orderType = 'startTime'}) {
    Dio dio =new Dio();
    return dio.get(Uri.encodeFull(
        'https://event-storage-api-ms.juejin.im/v2/getEventList?uid=&client_id=&token=&src=${httpHeaders['X-Juejin-Src']}&orderType=$orderType&cityAlias=$cityAlias&pageNum=$pageNum&pageSize=$pageSize'));
     
  }
  @override
  Widget build(BuildContext context){
    return new FutureBuilder(
      future: getActivities(cityAlias: widget.categories['cityAlias']),
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          var  activitiesList = json.decode(snapshot.data['d']);
          return new ListView.builder(
            itemCount: activitiesList.length,
            itemBuilder: (context,index){
              var item= activitiesList[index];
              return createItem(item);
            }
          );
        } else if (snapshot.hasError){
          return Text('Error:${snapshot.error}');
        }
        return new Container(
          color: new Color.fromRGBO(244, 245, 245, 1.0),
          child: new CupertinoActivityIndicator(),//ios菊花
        );
      },
    );
  }
  //单个ListItem
  Widget createItem(itemInfo) {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Column(),
    );
  }

}
