import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'product_row_item.dart';
import 'search_bar.dart';
import 'styles.dart';

// stateful widget
// 随着用户输入文本的变化，列表中的内容也会随之改变
class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

// 供我们保留特定于搜索的状态
class _SearchTabState extends State<SearchTab> {

  // late 关键字 待会再定义该变量的值
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  // 存储搜索字词
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final results = model.search(_terms);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color:Styles.scaffoldBackground
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ProductRowItem(
                  product: results[index],
                  lastItem: index == results.length - 1,
                ),
                itemCount: results.length,
              ),
            )
          ],
        ),
      ),
    );
  }

}