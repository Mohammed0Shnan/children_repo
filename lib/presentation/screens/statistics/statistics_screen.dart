import 'package:flutter/material.dart';
import 'package:child_app/presentation/screens/statistics/public_statistics.dart';

class StatisticsScreen extends StatefulWidget {
  final List types;

  const StatisticsScreen({Key key, this.types}) : super(key: key);
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState(types);
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  final List types;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: types.length);
  }

  _StatisticsScreenState(this.types);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: DefaultTabController(
              length: types.length,
              initialIndex: 0,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      isScrollable: false,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: Colors.purple[900],
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.only(top: 10),
                      indicatorWeight: 5,
                      tabs: types
                          .map((e) => Text(
                                e,
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold),
                              ))
                          .toList(),
                      controller: _tabController,
                    ),
                  ),
                ),
                body: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: types.map((e) => PublicStatistics()).toList()),
              ),
            )));
  }
}


// class TabBarSection extends StatefulWidget {
//   const TabBarSection({
//     Key key,
//   }) : super(key: key);

//   @override
//   _TabBarSectionState createState() => _TabBarSectionState();
// }

// class _TabBarSectionState extends State<TabBarSection>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(vsync: this, length: 2);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(50),
//             child: AppBar(
//               leading: SizedBox.shrink(),
//               backgroundColor: Colors.purple,
//               bottom: TabBar(
//                 indicatorColor: Colors.red,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 controller: _tabController,
//                 tabs: <Widget>[
//                   Text(
//                     'Text 1',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text(
//                     'Text 2',
//                     style: TextStyle(fontSize: 20),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           body: TabBarView(
//             physics: NeverScrollableScrollPhysics(),
//             controller: _tabController,
//             children: <Widget>[
//               Container(
//                 color: Colors.red,
//               ),
//               Container(
//                 height: 50,
//                 width: 50,
//                 color: Colors.yellow,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
