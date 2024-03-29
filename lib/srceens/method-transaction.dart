import 'package:audit/icons/my_icon_icons.dart';
import 'package:audit/srceens/add_transactions.dart';
import 'package:audit/srceens/detail_pin_screen.dart';
import 'package:audit/srceens/history_delete.dart';
import 'package:audit/srceens/list_transactions.dart';
import 'package:audit/srceens/pin_screen.dart';
import 'package:audit/srceens/summary_screen.dart';
import 'package:audit/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MethodTransaction extends StatelessWidget {
  static const routeName = '/method-transaction';
  _launchURL(String goUrl) async {
    String url = goUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
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
          height: (isLandScape)
              ? mediaQuery.size.height
              : mediaQuery.size.height - 58 - mediaQuery.padding.top,
          child: Column(
            children: <Widget>[
              (isLandScape) ? Container() : Chart(),
              Card(
                elevation: 5,
                child: ListTile(
                  leading: Icon(
                    Icons.add,
                    size: 40,
                    color: Color.fromRGBO(12, 28, 101, 1),
                  ),
                  title: Text('Add New Transaction Or Debt'),
                  onTap: () {
                    Navigator.of(context).pushNamed(AddTransactinos.routeName);
                  },
                ),
              ),
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
                    Icons.fiber_pin,
                    size: 40,
                    color: Color.fromRGBO(12, 28, 101, 1),
                  ),
                  title: Text('Active Pin'),
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailPinScreen.routeName);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading: Icon(
                    Icons.archive,
                    size: 40,
                    color: Color.fromRGBO(12, 28, 101, 1),
                  ),
                  title: Text('Summary'),
                  onTap: () {
                    Navigator.of(context).pushNamed(SummaryScreen.routeName);
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
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () => _launchURL(
                            'https://docs.google.com/document/d/1QEN_Bnh3_lw0c4SRlwsM936WLNBUdBgh6I4kwkucH24'),
                        icon: Icon(
                          MyIcon.privecy_police,
                          color: Color.fromRGBO(12, 28, 101, 1),
                          size: 35,
                        ),
                        label: Text('Privacy Policy'),
                      ),
                      FlatButton.icon(
                        onPressed: () => _launchURL(
                            'https://docs.google.com/document/d/1xk-42gbUYtiW17eFGmrT4YarjUiurO6Q2ewxI74OpyA'),
                        icon: Icon(
                          MyIcon.usage_agreement_,
                          color: Color.fromRGBO(12, 28, 101, 1),
                          size: 35,
                        ),
                        label: Text('Usage Agreement'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
