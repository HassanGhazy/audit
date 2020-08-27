import 'package:audit/providers/transacts.dart';
import 'package:audit/srceens/add_transactions.dart';
import 'package:audit/srceens/history_delete.dart';
import 'package:audit/srceens/list_transactions.dart';
import 'package:audit/srceens/method-transaction.dart';
// import 'package:audit/srceens/test_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Transacts(),
      child: MaterialApp(
        title: 'Audit',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 49, 112, 1),
        ),
        home: MethodTransaction(),
        debugShowCheckedModeBanner: false,
        routes: {
          AddTransactinos.routeName: (ctx) => AddTransactinos(),
          ListTransactions.routeName: (ctx) => ListTransactions(),
          HistoryDelete.routeName: (ctx) => HistoryDelete(),
        },
      ),
    );
  }
}
