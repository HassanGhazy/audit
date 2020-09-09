// import 'package:audit/providers/transacts.dart';
import 'package:audit/widgets/debts_item.dart';
import 'package:audit/widgets/search.dart';
import 'package:audit/widgets/transactions_item.dart';
import 'package:flutter/material.dart';

class ListTransactions extends StatefulWidget {
  static const routeName = '/list-tranasctions';

  @override
  _ListTransactionsState createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {
  bool _isOn = false;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    // final isLandScape = mediaQuery.orientation == Orientation.landscape;
    List<Widget> _widgetOptions = <Widget>[
      TransactionsItem(),
      DebtsItem(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text((_selectedIndex == 0) ? 'List Transactions' : 'List Debts'),
        actions: <Widget>[Search()],
      ),
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // SingleChildScrollView(
      // child: Column(
      //   children: <Widget>[
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Text(
      //           'Show Transactions',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         Switch(
      //           value: _isOn,
      //           activeColor: Theme.of(context).primaryColor,
      //           inactiveThumbColor: Theme.of(context).primaryColor,
      //           activeTrackColor: Colors.grey[400],
      //           inactiveTrackColor: Colors.grey[400],
      //           onChanged: (value) => setState(() {
      //             _isOn = value;
      //           }),
      //         ),
      //         // Color.fromRGBO(0, 255, 241, 1)
      //         Text(
      //           'Show Debts',
      //           style: TextStyle(
      //             color: Colors.white,
      //           ),
      //         )
      //       ],
      //     ),
      //     Divider(
      //       color: Colors.white,
      //     ),
      // (_isOn)
      //     ? Container(
      //         height: (isLandScape)
      //             ? mediaQuery.size.height * .6
      //             : mediaQuery.size.height * .75,
      //         child: DebtsItem(),
      //       )
      //     : Container(
      //         height: (isLandScape)
      //             ? mediaQuery.size.height * .6
      //             : mediaQuery.size.height * .75,
      //         child: TransactionsItem(),
      //       )
      //   ],
      // ),
      // ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                title: Text('Transaction'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.money_off),
                title: Text('Debt'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromRGBO(12, 28, 101, 1),
            onTap: _onItemTapped,
            backgroundColor: Colors.grey[200],
          ),
        ),
      ),
    );
  }
}
