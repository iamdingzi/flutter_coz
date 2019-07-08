import 'package:flutter/material.dart';

class ChangeTypeList extends StatelessWidget {
  final items = List<ListItem>.generate(
      1200,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem("sender $i", "Message body $i"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text('Floating app bar'),
          floating: true,
          flexibleSpace: Image.network(
              'https://pics1.baidu.com/feed/f9198618367adab413ced7a334184e188601e402.jpeg?token=39e37baf7b29f8db10ff3e4043533c9f&s=BC93DEB2422B8AEE53ACDC2C03007041'),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = items[index  ];

            if (item is HeadingItem) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SecondPage(heading: item.heading)));
                },
                child: Hero(
                  tag: item.heading,
                  child: Center(
                    child: Text(
                      item.heading,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
              );
            } else if (item is MessageItem) {
              return ListTile(
                title: Text(item.sender),
                subtitle: Text(item.body),
              );
            }
          }, childCount: items.length),
        )
      ]),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String heading;

  const SecondPage({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(heading),
      ),
      body: Hero(
        tag: heading,
        child: Center(
          child: Text(
            heading,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
