import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/hot.dart';
import '../pages/discovery.dart';
import '../pages/mine.dart';
class IndexPage extends StatefulWidget{
  @override
  createState() => new IndexPageState();
}
class IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomTabs=[
    new BottomNavigationBarItem(
      icon: new Icon(CupertinoIcons.home),
      title: new Text('首页'),
    ),

    new BottomNavigationBarItem(
      icon: new Icon(CupertinoIcons.conversation_bubble),
      title: new Text('沸点'),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(CupertinoIcons.search),
      title: new Text('搜索'),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(CupertinoIcons.profile_circled),
      title: new Text('我的'),
    )
  ];
  final List tabBodies=[
    new HomePage(),
    //new HotPage(),
    new HotPage(),
    new DiscoveryPage(),
    new MinePage()
  ];
  int currentIndex=0;
  var currentPage;

  @override  
  void initState() {
    super.initState();
    currentPage=tabBodies[currentIndex];
  }
  
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: new Color.fromRGBO(244, 255, 255, 1.0),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          print('currentIndex:${currentIndex}');
          print('tabBodies:${tabBodies.length}');
          setState(() {
                  currentIndex=index;
                  currentPage= tabBodies[currentIndex];    
                  });
        },        
      ),
      body: currentPage,
    );
  }
}