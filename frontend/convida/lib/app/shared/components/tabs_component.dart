import 'package:convida/app/screens/favorites_screen/favorites_widget.dart';
import 'package:convida/app/screens/my_confirmed_events_screen/my_confirmed_widget.dart';
import 'package:convida/app/screens/my_events_screen/my_events_widget.dart';
import 'package:convida/app/shared/check_token/check_token.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> with TickerProviderStateMixin {
  TabController _controller;
  double sizeAppBarIcon = 20;
  int currentIndex = 0;

  @override
  void initState() {
    _controller = new TabController(
      length: 3,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: FutureBuilder(
          future: checkToken(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Container(
              padding: EdgeInsets.only(top: 3.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Card(
                        child: new TabBar(
                          onTap: (value) => setState(() {
                            currentIndex = value;
                          }),
                          controller: _controller,
                          //  isScrollable: true,
                          tabs: [
                            Tab(
                              icon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey[500],
                                  size: sizeAppBarIcon
                              ),
                              child: Text(
                                "Criados",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize:  12.2),
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.grey[500],
                                  size: sizeAppBarIcon
                              ),
                              child: Text(
                                "Favoritos",
                                style: TextStyle(
                                    color:  Colors.grey[500],
                                    fontSize: 12.2),
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                  Icons.fact_check_outlined,
                                  color:  Colors.grey[500],
                                  size:  sizeAppBarIcon
                              ),
                              child: Text(
                                "Confirmados",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize:  12.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      height: 500.0,
                      child: new TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          MyEventsWidget(),
                          FavoritesWidget(),
                          ConfirmedWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}