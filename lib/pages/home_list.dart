import 'package:flutter/material.dart';
import 'package:nippo/components/atoms/app_logo.dart';
import 'package:nippo/pages/create.dart';
import 'package:nippo/repositories/post_repository.dart';
import 'package:nippo/theme.dart';
import 'package:nippo/components/organisms/post_data_list_view.dart';

class HomeListPage extends StatelessWidget {
  final List<Tab> tabItems = <Tab>[
    const Tab(
      text: 'みんなの日報',
    ),
    const Tab(
      text: 'お気に入り',
    ),
  ];

  Widget tabBarContainer({String tabText}) {
    if (tabText.toLowerCase().contains(tabItems[0].text)) {
      return PostDataListView(future: PostRepository().fetchAll());
    }
    if (tabText.toLowerCase().contains(tabItems[1].text)) {
      return const Center(
        child: Text('お気に入りは未実装'),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabItems.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const AppLogo(height: 50),
          bottom: TabBar(
            tabs: tabItems,
            indicatorColor: VIC.navy,
            labelColor: VIC.navy,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: const Color(0xFFAAAAAA),
          ),
        ),
        body: SafeArea(
            child: TabBarView(
          children: tabItems.map((tab) {
            return tabBarContainer(tabText: tab.text);
          }).toList(),
        )),
        floatingActionButton: FAB(),
      ),
    );
  }
}

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute<MaterialPageRoute>(
              builder: (BuildContext context) {
                return CreatePage();
              },
              fullscreenDialog: true,
            ));
      },
      child: Icon(Icons.mode_edit),
      backgroundColor: VIC.red,
    );
  }
}
