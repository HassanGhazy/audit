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
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text('List Transactions'),
        actions: <Widget>[Search()],
      ),
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Show Transactions',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  value: _isOn,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveThumbColor: Theme.of(context).primaryColor,
                  activeTrackColor: Colors.grey[400],
                  inactiveTrackColor: Colors.grey[400],
                  onChanged: (value) => setState(() {
                    _isOn = value;
                  }),
                ),
                // Color.fromRGBO(0, 255, 241, 1)
                Text(
                  'Show Debts',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            (_isOn)
                ? Container(
                    height: (isLandScape)
                        ? mediaQuery.size.height * .6
                        : mediaQuery.size.height * .75,
                    child: DebtsItem(),
                  )
                : Container(
                    height: (isLandScape)
                        ? mediaQuery.size.height * .6
                        : mediaQuery.size.height * .75,
                    child: TransactionsItem(),
                  )
          ],
        ),
      ),
    );
  }
}
