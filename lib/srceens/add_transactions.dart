import 'package:audit/widgets/new_debt.dart';
import 'package:audit/widgets/new_transactions.dart';
import 'package:flutter/material.dart';

class AddTransactinos extends StatefulWidget {
  static const routeName = '/add-transactions';
  @override
  _AddTransactinosState createState() => _AddTransactinosState();
}

class _AddTransactinosState extends State<AddTransactinos> {
  // final controllerPage = PageController(
  //   initialPage: 0,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add New Transaction or Debt'),
        ),
        body: NewDebt()
        // (
        //   // controller: controllerPage,
        //   children: <Widget>[
        //     // NewTransactinos(),
        //     NewDebt(),
        //   ],
        // ),
        );
  }
}
