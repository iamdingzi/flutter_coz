import 'package:flutter/material.dart';

class TabBarBottomPageWidget extends StatefulWidget {
  @override
  _TabBarBottomPageWidgetState createState() => _TabBarBottomPageWidgetState();
}

class _TabBarBottomPageWidgetState extends State<TabBarBottomPageWidget> {
  final PageController pageController = PageController();

  final List<String> tab = ["动态", "趋势", "我的"];

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _renderTab() {
    List<Widget> list = [];
    for (int i = 0; i < tab.length; i++) {
      list.add(FlatButton(
        onPressed: () {
          pageController.jumpTo(MediaQuery.of(context).size.width * i);
        },
        child: Text(
          tab[i],
          maxLines: 1,
        ),
      ));
      return list;
    }
  }
}
