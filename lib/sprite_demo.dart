import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  NodeWithSize rootNode;


  @override
  void initState() {
    super.initState();
    rootNode = NodeWithSize(const Size(1024,1024));
  }

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(rootNode);
  }
}
