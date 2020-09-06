import 'package:audit/providers/transacts.dart';
import 'package:audit/widgets/sub_debt_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebtsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    return FutureBuilder(
      future: Provider.of<Transacts>(context).fetchAndSetTransaction(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Transacts>(
                  child: Center(
                    child: Text(
                      'There is no Debts.',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(247, 78, 126, 1),
                      ),
                    ),
                  ),
                  builder: (ctx, transacts, ch) {
                    for (var i = 0; i < transacts.transactoin.length; i++) {
                      if (transacts.transactoin[i].type == 'Debt') {
                        _isEmpty = false;
                      }
                    }
                    return (_isEmpty) ? ch : SubDebtItem();
                  }),
    );
  }
}
