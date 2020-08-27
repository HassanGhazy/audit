import 'package:audit/providers/transacts.dart';
import 'package:audit/widgets/search_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryDelete extends StatelessWidget {
  static const routeName = '/history-delete';
  @override
  Widget build(BuildContext context) {
    final transacts = Provider.of<Transacts>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('History Delete'),
        actions: <Widget>[SearchHistory()],
      ),
      body: FutureBuilder(
        future: transacts.fetchAndSetDelTransaction(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  (transacts.historyDelete.isNotEmpty)
                      ? Container(
                          height: MediaQuery.of(context).size.height * .8,
                          child: ListView.builder(
                            itemCount: transacts.historyDelete.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      '${transacts.historyDelete[i].name}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    trailing: Container(
                                      width: 100,
                                      height: 100,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '${transacts.historyDelete[i].description}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    leading: FittedBox(
                                      child: CircleAvatar(
                                        maxRadius: 45,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            '${transacts.historyDelete[i].amount} ${transacts.historyDelete[i].currncy}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        ),
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Type: ${transacts.historyDelete[i].type}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          'Date Trans: ${transacts.historyDelete[i].oldDate}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          'Date Del: ${DateFormat.yMEd().add_jms().format(DateTime.parse(transacts.historyDelete[i].newDate)).toString()}', //Due date

                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 200),
                          child: Center(
                            child: Text(
                              'No Deleted Transactions Exist',
                              style: TextStyle(
                                  color: Color.fromRGBO(247, 78, 126, 1),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      child: RaisedButton.icon(
                        onPressed: () {
                          (transacts.historyDelete.isEmpty)
                              ? showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    title: Text('History'),
                                    content:
                                        Text('Your history is already empty'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: Text('Okey'),
                                      ),
                                    ],
                                  ),
                                )
                              : showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    title: Text('Clear History'),
                                    content: Text('Are you Sure ?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: Text('cancel'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          transacts.emptyHistory();

                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  ),
                                );
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 30,
                        ),
                        label: Text(
                          'Delete Forever',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color.fromRGBO(12, 28, 101, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
    );
  }
}
