import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hackathon/authentication/authentication.dart';
import 'package:flutter_hackathon/home/FollowCommunity.dart';
import 'package:flutter_hackathon/home/FollowingCommunity.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  final List<Tab> tabs = <Tab>[
    new Tab(text: "Follow"),
    new Tab(text: "Following"),
  ];
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Flutter World",style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: Colors.black,
            tabBarIndicatorSize: TabBarIndicatorSize.tab
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FollowCommunity(),
          FollowingCommunity()
        ]
      ),
    );
  }
}
