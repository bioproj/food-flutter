import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'model/homelist.dart';
import 'package:flutterproj/app_theme.dart';
// void main() {
//   runApp(MyApp());
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: CircularHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _CircularHomePageState createState() => _CircularHomePageState();
}

class _CircularHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  static const int totalPage = 4;
  static const List<String> names = [
    '首页',
    '营养师',
    '发现',
    '我的',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.movie,
    Icons.timer,
    Icons.multiline_chart
  ];

  static const List<Color> colors = [
    Colors.blueGrey,
    Colors.teal,
    Colors.blue,
    Colors.brown
  ];

  int _currentPage = 0;
  final _pageController = PageController();
  // @override
  // void initState() {
  //   super.initState();
  // }
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BottomBarPageTransition(
      //   builder: (_, index) => _getBody(index),
      //   currentIndex: _currentPage,
      //   totalLength: totalPage,
      //   transitionType: transitionType,
      //   transitionDuration: duration,
      //   transitionCurve: curve,
      // ),
      bottomNavigationBar: _getBottomBar(),
      body: _getBody(),
      // appBar: _appBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text('缮菌健康'),
      centerTitle: true,
      actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.search))],
    );
  }

  //主页面
  Widget _getBody() {
    return PageView(
      controller: _pageController,
      children: [
        // Container(
        //   // color: Colors.blue,
        //   child:
        // ),
        Container(color: Colors.red),
        FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: <Widget>[_bodyExpanded()],
                  children: <Widget>[appBar(), _bodyExpanded()],
                ),
              );
            }
          },
        ),

        Container(color: Colors.greenAccent.shade700),
        Container(color: Colors.orange),
      ],
      onPageChanged: (index) {
        setState(() => _currentPage = index);
      },
    );
  }

  Widget _bodyExpanded() {
    return Expanded(
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                homeList.length,
                (int index) {
                  final int count = homeList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  return HomeListView(
                    animation: animation,
                    animationController: animationController,
                    listData: homeList[index],
                    callBack: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              homeList[index].navigateScreen!,
                        ),
                      );
                    },
                  );
                },
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: multiple ? 2 : 1,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 1.5,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _getBottomBar() {
    return BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          // 页面跳转
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
            totalPage,
            (index) => BottomNavigationBarItem(
                  icon: Icon(icons[index]),
                  label: names[index],
                )));
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Flutter UI',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: isLightMode ? AppTheme.dark_grey : AppTheme.white,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _getBottomBar() {
  //   return BottomNavigationBar(
  //       currentIndex: _currentPage,
  //       onTap: (index) {
  //         _currentPage = index;
  //         setState(() {});
  //       },
  //       selectedItemColor: Colors.blue,
  //       unselectedItemColor: Colors.grey,
  //       type: BottomNavigationBarType.fixed,
  //       items: List.generate(
  //           totalPage,
  //           (index) => BottomNavigationBarItem(
  //                 icon: Icon(icons[index]),
  //                 label: names[index],
  //               )));
  // }

  // Duration duration = Duration(milliseconds: 300);
  // Curve curve = Curves.ease;
  // TransitionType transitionType = TransitionType.circular;

  // String selectedDuration = '300ms';
  // String selectedTransactionType = 'Circular';
  // String selectedCurve = 'Ease';

  // Widget _getBody(int index) {
  //   return CustomScrollView(
  //     slivers: <Widget>[
  //       SliverAppBar(
  //         title: Text(selectedTransactionType),
  //         backgroundColor: <Color>[
  //           Colors.blue,
  //           Colors.indigo,
  //           Colors.blueGrey,
  //           Colors.green
  //         ][index],
  //       ),
  //       SliverFillRemaining(
  //         child: Container(
  //           color: colors[index],
  //           padding: EdgeInsets.all(10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               Text(names[index],
  //                   style: TextStyle(fontSize: 50, color: Colors.white)),
  //               if (index == 1)
  //                 _getMenuButton(
  //                     <String>['Circular', 'Slide', 'Fade'],
  //                     selectedTransactionType,
  //                     (_) => setState(() {
  //                           selectedTransactionType = _!;
  //                           if (_ == 'Circular')
  //                             transitionType = TransitionType.circular;
  //                           else if (_ == 'Slide')
  //                             transitionType = TransitionType.slide;
  //                           else if (_ == 'Fade')
  //                             transitionType = TransitionType.fade;
  //                         })),
  //               if (index == 2)
  //                 _getMenuButton(
  //                     <String>['300ms', '500ms', '1s', '2s'],
  //                     selectedDuration,
  //                     (_) => setState(() {
  //                           selectedDuration = _!;
  //                           if (_ == '300ms')
  //                             duration = Duration(milliseconds: 300);
  //                           else if (_ == '500ms')
  //                             duration = Duration(milliseconds: 500);
  //                           else if (_ == '1s')
  //                             duration = Duration(seconds: 1);
  //                           else if (_ == '2s') duration = Duration(seconds: 2);
  //                         })),
  //               if (index == 3)
  //                 _getMenuButton(
  //                     <String>[
  //                       'Ease',
  //                       'EaseIn',
  //                       'Elastic In Out',
  //                       'Bounce In Out'
  //                     ],
  //                     selectedCurve,
  //                     (_) => setState(() {
  //                           selectedCurve = _!;
  //                           if (_ == 'Ease')
  //                             curve = Curves.ease;
  //                           else if (_ == 'EaseIn')
  //                             curve = Curves.easeIn;
  //                           else if (_ == 'Elastic In Out')
  //                             curve = Curves.elasticInOut;
  //                           else if (_ == 'Bounce In Out')
  //                             curve = Curves.bounceInOut;
  //                         })),
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // _getMenuButton(List<String> list, String selectedValue,
  //     ValueChanged<String?> onSelected) {
  //   return Theme(
  //       data: ThemeData.dark(),
  //       child: DropdownButton(
  //           underline: SizedBox(),
  //           value: selectedValue,
  //           items: List.generate(
  //               list.length,
  //               (index) => DropdownMenuItem<String>(
  //                     child: Text(list[index]),
  //                     value: list[index],
  //                   )),
  //           onChanged: onSelected));
  // }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
