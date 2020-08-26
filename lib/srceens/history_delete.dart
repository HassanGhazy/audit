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
      body: (transacts.historyDelete.isNotEmpty)
          ? ListView.builder(
              itemCount: transacts.historyDelete.length,
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        '${transacts.historyDelete[i].name}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        '${transacts.historyDelete[i].description}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: CircleAvatar(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            '${transacts.historyDelete[i].amount}${transacts.historyDelete[i].currncy}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Type: ${transacts.historyDelete[i].type}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Old Date: ${transacts.historyDelete[i].oldDate}', //the date here is old date
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Due Date: ${DateFormat.yMEd().add_jms().format(transacts.historyDelete[i].newDate)}', //Due date

                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Text(
                'No Deleted Transactions Exist',
                style: TextStyle(
                    color: Color.fromRGBO(247, 78, 126, 1), fontSize: 20),
              ),
            ),
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
    );
  }
}
