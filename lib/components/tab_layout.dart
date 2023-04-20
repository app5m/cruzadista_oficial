import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';



class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> {
  int _selectedIndex = 0;

  List<String> _tabs = ['Pendentes', 'Finalizadas'];
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];


  Widget _buildTab(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Container(child:
            Text('Content of Tab 1'),
            )
          ],
        );
      case 1:
        return Text('Content of Tab 2');
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildTab(0),
                _buildTab(1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
