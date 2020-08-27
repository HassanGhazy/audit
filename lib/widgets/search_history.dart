import 'package:audit/models/transaction.dart';
import 'package:audit/providers/transacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

class SearchHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transacts = Provider.of<Transacts>(context);

    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      child: Icon(Icons.search),
      tooltip: 'Search Transactions',
      onPressed: () => showSearch(
        context: context,
        delegate: SearchPage<Transaction>(
          items: transacts.historyDelete,
          searchLabel: 'Search',
          suggestion: Center(
            child: Text('Search Transaction by name or Type'),
          ),
          failure: Center(
            child: Text('No Transactions found'),
          ),
          filter: (transaction) => [
            transaction.name,
            transaction.type,
          ],
          builder: (transaction) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(transaction.name),
                  subtitle: Text(transaction.oldDate.toString()),
                  trailing: Text(transaction.type),
                  leading: CircleAvatar(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text('${transaction.amount}'),
                    ),
                    backgroundColor: Color.fromRGBO(0, 14, 89, 1),
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
