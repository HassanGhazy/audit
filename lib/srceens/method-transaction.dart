import 'package:audit/icons/my_icon_icons.dart';
import 'package:audit/srceens/add_transactions.dart';
import 'package:audit/srceens/history_delete.dart';
import 'package:audit/srceens/list_transactions.dart';
// import 'package:audit/srceens/test_switch.dart';
import 'package:audit/widgets/chart.dart';
import 'package:flutter/material.dart';

class MethodTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(MyIcon.logo),
            Padding(padding: EdgeInsets.only(right: 20)),
            Text('Audit'),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddTransactinos.routeName);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .848 +
              MediaQuery.of(context).padding.top,
          child: Column(
            children: <Widget>[
              Chart(),
              Card(
                elevation: 5,
                child: ListTile(
                  leading: Icon(
                    MyIcon.path_17,
                    size: 40,
                    color: Color.fromRGBO(12, 28, 101, 1),
                  ),
                  title: Text('List Of Transactions'),
                  onTap: () {
                    Navigator.of(context).pushNamed(ListTransactions.routeName);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    size: 40,
                    color: Color.fromRGBO(12, 28, 101, 1),
                  ),
                  title: Text('History Delete'),
                  onTap: () {
                    Navigator.of(context).pushNamed(HistoryDelete.routeName);
                  },
                ),
              ),

              Spacer(),

              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            MyIcon.privecy_police,
                            color: Color.fromRGBO(12, 28, 101, 1),
                          ),
                          label: Text('Privacy Policy')),
                      FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            MyIcon.usage_agreement_,
                            color: Color.fromRGBO(12, 28, 101, 1),
                          ),
                          label: Text('Usage Agreement')),
                    ],
                  ),
                ),
              )
              // Card(
              //   elevation: 5,
              //   child: ListTile(
              //     title: Text('Test Switch'),
              //     onTap: () {
              //       Navigator.of(context).pushNamed(TestSwitch.routeName);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
