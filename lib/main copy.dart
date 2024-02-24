import 'package:flutter/material.dart';
import 'package:flutterproj/page/home/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Demo'),
              actions: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("Edward"),
                    accountEmail: Text("1749748955@qq.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "http://wangyang-bucket.oss-cn-beijing.aliyuncs.com/cms/image/admin.jpg"),
                    ),
                  ),
                  ListTile(
                    title: Text("Item 1"),
                    onTap: () {},
                    trailing: Icon(Icons.feed),
                  ),
                  ListTile(
                    title: Text("Item 1"),
                    onTap: () {},
                    trailing: Icon(Icons.feed),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("注销"),
                    onTap: () {},
                    trailing: Icon(Icons.exit_to_app),
                  ),
                ],
              ),
            ),
            body: Center(
              child: TabBarView(
                children: [Home(), Text("aaa"), Text("aaa")],
              ),
            ),
            bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 253, 253, 253)),
                // height: 50,
                child: TabBar(
                  // labelStyle: TextStyle(height: 0, fontSize: 10),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                      text: "首页",
                    ),
                    Tab(
                      icon: Icon(Icons.home),
                      text: "营养师",
                    ),
                    Tab(
                      icon: Icon(Icons.home),
                      text: "我的",
                    )
                  ],
                ))));
  }
}
