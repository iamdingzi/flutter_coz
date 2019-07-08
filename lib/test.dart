import 'package:flutter/material.dart';

class WhatAPps extends StatefulWidget {
  @override
  _WhatAPpsState createState() => _WhatAPpsState();
}

class _WhatAPpsState extends State<WhatAPps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Text(
                'do some thing $index',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              );
            }),
      ),
    );
  }
}
