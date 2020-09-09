import 'package:audit/providers/transacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SubDebtItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String oldAmount;
    String oldCurrncy;
    final transacts = Provider.of<Transacts>(context);
    return ListView.builder(
      itemCount: transacts.transactoin.length,
      itemBuilder: (context, i) {
        final _amountController =
            TextEditingController(text: '${transacts.transactoin[i].amount}');
        return Column(
          children: <Widget>[
            (transacts.transactoin[i].type == 'Debt')
                ? ListTile(
                    title: Text(
                      '${transacts.transactoin[i].name}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${(DateFormat.yMEd().add_jms().format(DateTime.parse(transacts.transactoin[i].newDate))).toString()}',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          title: Text('Decription Transaction'),
                          content: Text(
                            '${transacts.transactoin[i].description}',
                            style: TextStyle(
                                color: Colors.purple[900], fontSize: 20),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Okey'),
                            ),
                          ],
                        ),
                      );
                    },
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
                                'you try to delete Debt with this detail\n Name: ${transacts.transactoin[i].name}\n Amount: ${transacts.transactoin[i].amount}\n Description: ${transacts.transactoin[i].description}\n Currncey: ${transacts.transactoin[i].currncy}\n Date: ${transacts.transactoin[i].oldDate}\nType: ${transacts.transactoin[i].type}'),
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
                                  transacts.addTransaction(
                                      transacts.transactoin[i].name,
                                      transacts.transactoin[i].amount,
                                      'Payment from ${transacts.transactoin[i].name}',
                                      transacts.transactoin[i].currncy,
                                      'Transaction',
                                      transacts.transactoin[i].newDate);

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
                    leading: FittedBox(
                      child: CircleAvatar(
                        maxRadius: 35,
                        backgroundColor: Color.fromRGBO(12, 28, 101, 1),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                title: Text('Amount Transaction'),
                                content: Container(
                                  height: 140,
                                  child: Column(
                                    children: <Widget>[
                                      TextField(
                                          onChanged: (oldAmount1) {
                                            oldAmount = oldAmount1;
                                          },
                                          decoration: InputDecoration(
                                              helperText: 'Amount'),
                                          controller: _amountController),
                                      TextField(
                                        onChanged: (oldCurrncy1) {
                                          oldCurrncy = oldCurrncy1;
                                        },
                                        decoration: InputDecoration(
                                            helperText: 'Currncy'),
                                        controller: TextEditingController(
                                            text:
                                                '${transacts.transactoin[i].currncy}'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      if (oldCurrncy == null) {
                                        oldCurrncy =
                                            transacts.transactoin[i].currncy;
                                      }
                                      if (oldAmount == null) {
                                        oldAmount = transacts
                                            .transactoin[i].amount
                                            .toString();
                                      }
                                      if (oldAmount ==
                                              transacts.transactoin[i].amount
                                                  .toString() &&
                                          oldCurrncy !=
                                              transacts
                                                  .transactoin[i].currncy) {
                                        transacts.updateTransaction(
                                            double.parse(oldAmount),
                                            oldCurrncy,
                                            transacts.transactoin[i].id);
                                      } else if (double.tryParse(oldAmount) !=
                                          null) {
                                        transacts.updateTransaction(
                                            double.parse(oldAmount),
                                            oldCurrncy,
                                            transacts.transactoin[i].id);

                                        transacts.addTransaction(
                                            transacts.transactoin[i].name,
                                            (transacts.transactoin[i].amount -
                                                double.parse(oldAmount)),
                                            'Payment from ${transacts.transactoin[i].name}',
                                            transacts.transactoin[i].currncy,
                                            'Transaction',
                                            transacts.transactoin[i].newDate);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              '${transacts.transactoin[i].amount} ${transacts.transactoin[i].currncy}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            (transacts.transactoin[i].type == 'Debt')
                ? Divider(
                    color: Colors.white,
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
