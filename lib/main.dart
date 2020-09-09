import 'package:audit/providers/transacts.dart';
import 'package:audit/srceens/add_transactions.dart';
import 'package:audit/srceens/detail_pin_screen.dart';
import 'package:audit/srceens/history_delete.dart';
import 'package:audit/srceens/list_transactions.dart';
import 'package:audit/srceens/method-transaction.dart';
import 'package:audit/srceens/pin_screen.dart';
import 'package:audit/srceens/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Transacts(),
      child: MaterialApp(
        title: 'Audit',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 49, 112, 1),
        ),
        home: PinScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AddTransactinos.routeName: (ctx) => AddTransactinos(),
          ListTransactions.routeName: (ctx) => ListTransactions(),
          HistoryDelete.routeName: (ctx) => HistoryDelete(),
          DetailPinScreen.routeName: (ctx) => DetailPinScreen(),
          PinScreen.routeName: (ctx) => PinScreen(),
          MethodTransaction.routeName: (ctx) => MethodTransaction(),
          SummaryScreen.routeName: (ctx) => SummaryScreen(),
        },
      ),
    );
  }
}
