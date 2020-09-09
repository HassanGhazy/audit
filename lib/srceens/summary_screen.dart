import 'package:audit/providers/transacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatelessWidget {
  static const routeName = '/summary-screen';
  @override
  Widget build(BuildContext context) {
    final transacts = Provider.of<Transacts>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
      appBar: AppBar(
        title: Text('Summary'),
        backgroundColor: Color.fromRGBO(0, 14, 89, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (transacts.transactoin.length == 0)
                    ? ''
                    : 'Total Debts ${transacts.total()[0]}',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(247, 78, 126, 1),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8)),
              Text(
                (transacts.transactoin.length == 0)
                    ? ''
                    : 'Total Transaction ${transacts.total()[1]}',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(247, 78, 126, 1),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8)),
              Text(
                (transacts.transactoin.length == 0)
                    ? ''
                    : 'have high debt ${transacts.total()[2]} ${transacts.total()[6]} and he from \"${transacts.total()[3]}\"',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(247, 78, 126, 1),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8)),
              Text(
                (transacts.transactoin.length == 0)
                    ? ''
                    : 'The high transaction it was ${transacts.total()[4]}  ${transacts.total()[7]}  because \"${transacts.total()[5]}\"',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(247, 78, 126, 1),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8)),
              Text(
                (transacts.currncyAndAmount['Total'].length == 0)
                    ? ''
                    : 'List of Debts',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(247, 78, 126, 1),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8)),
              Container(
                height: 150,
                width: 300,
                child: (transacts.currncyAndAmount['Total'].length == null ||
                        transacts.currncyAndAmount['Total'].length == 0)
                    ? Container()
                    : ListView.builder(
                        itemBuilder: (context, i) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${transacts.currncyAndAmount['Total'].elementAt(i)['amount']}',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(247, 78, 126, 1),
                                ),
                              ),
                              Text(
                                '${transacts.currncyAndAmount['Total'].elementAt(i)['currncy']}',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(247, 78, 126, 1),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: transacts.currncyAndAmount['Total'].length,
                      ),
              ),
              Text(
                (transacts.currncyAndAmount['Total'].length == 0)
                    ? ''
                    : 'you need to restart your app to update your values list debts',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(247, 78, 126, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
