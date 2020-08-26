import 'package:audit/providers/transacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transacts = Provider.of<Transacts>(context);
    return (transacts.transactoin.isNotEmpty)
        ? ListView.builder(
            itemCount: transacts.transactoin.length,
            itemBuilder: (context, i) {
              Divider(
                color: Colors.white,
              );
              return Column(
                children: <Widget>[
                  (transacts.transactoin[i].type == 'Transaction')
                      ? ListTile(
                          title: Text(
                            '${transacts.transactoin[i].name}',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${DateFormat("yyyy-MM-dd hh:mm").format(transacts.transactoin[i].oldDate)}',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  title: Text('Delete Transaction'),
                                  content: Text(
                                      'you try to delete Transaction with this detail\n Name: ${transacts.transactoin[i].name}\n Amount: ${transacts.transactoin[i].amount}\n Description: ${transacts.transactoin[i].description}\n Currncey: ${transacts.transactoin[i].currncy}\n Date: ${DateFormat("yyyy-MM-dd hh:mm").format(transacts.transactoin[i].oldDate)}\nType: ${transacts.transactoin[i].type}'),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: Text('cancel'),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        transacts.addToDeleteHistory(
                                          transacts.transactoin[i].id,
                                          transacts.transactoin[i].name,
                                          transacts.transactoin[i].amount,
                                          transacts.transactoin[i].description,
                                          transacts.transactoin[i].currncy,
                                          transacts.transactoin[i].oldDate,
                                          transacts.transactoin[i].type,
                                        );

                                        transacts.deleteTransaction(
                                            transacts.transactoin[i].id);

                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            color: Theme.of(context).errorColor,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromRGBO(12, 28, 101, 1),
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  '${transacts.transactoin[i].amount}',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        )
                      : Container(),
                  (transacts.transactoin[i].type == 'Transaction')
                      ? Divider(
                          color: Colors.white,
                        )
                      : Container(),
                ],
              );
            },
          )
        : Center(
            child: Text(
              'There is no Transactions yet.',
              style: TextStyle(
                  fontSize: 25, color: Color.fromRGBO(247, 78, 126, 1)),
            ),
          );
  }
}
