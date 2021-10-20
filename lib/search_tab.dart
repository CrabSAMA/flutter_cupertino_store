import 'package:flutter/cupertino.dart';

// stateful widget
// 随着用户输入文本的变化，列表中的内容也会随之改变
class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Search'),
        )
      ],
    );
  }

}