import 'package:audit/helpers/db_helper.dart';
import 'package:audit/helpers/db_helper2.dart';
import 'package:audit/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Transacts with ChangeNotifier {
  List<Transaction> _transaction = [];
  List<Transaction> _historyDelete = [];

  List<Transaction> get transactoin {
    return [..._transaction];
  }

  List<Transaction> get historyDelete {
    return [..._historyDelete];
  }

  void addTransaction(String name, double amount, String desc, String curr,
      String type, String date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        name: name,
        amount: amount,
        description: desc,
        currncy: curr,
        oldDate:
            DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()).toString(),
        newDate: date,
        type: type);

    _transaction.add(newTransaction);
    notifyListeners();

    DBHelper.insert('transactio', {
      'id': newTransaction.id,
      'name': newTransaction.name,
      'amount': newTransaction.amount,
      'description': newTransaction.description,
      'currncy': newTransaction.currncy,
      'oldDate': newTransaction.oldDate,
      'newDate': newTransaction.newDate,
      'type': newTransaction.type,
    });
  }

  Future<void> fetchAndSetTransaction() async {
    final dataList = await DBHelper.getData('transactio');
    _transaction = dataList
        .map((trans) => Transaction(
            id: trans['id'],
            name: trans['name'],
            amount: trans['amount'],
            description: trans['description'],
            currncy: trans['currncy'],
            oldDate: trans['oldDate'],
            newDate: trans['newDate'],
            type: trans['type']))
        .toList();
  }

  void deleteTransaction(String id) async {
    final db = await DBHelper.database();
    await db.delete(
      'transactio',
      where: "id = ?",
      whereArgs: [id],
    );

    final existingProductIndex =
        _transaction.indexWhere((trans) => trans.id == id);

    _transaction.removeAt(existingProductIndex);
    notifyListeners();
  }

  void emptyHistory() async {
    final db = await DBHelper2.database();
    await db.delete(
      'delTran',
    );

    _historyDelete.clear();
    notifyListeners();
  }

  void addToDeleteHistory(String id, String name, double amount, String desc,
      String curr, String date, String type) {
    final oldTransaction = Transaction(
      id: id,
      name: name,
      amount: amount,
      description: desc,
      currncy: curr,
      oldDate: date,
      newDate:
          DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()).toString(),
      type: type,
    );

    _historyDelete.add(oldTransaction);
    notifyListeners();

    DBHelper2.insert('delTran', {
      'id': oldTransaction.id,
      'name': oldTransaction.name,
      'amount': oldTransaction.amount,
      'description': oldTransaction.description,
      'currncy': oldTransaction.currncy,
      'oldDate': oldTransaction.oldDate,
      'newDate': oldTransaction.newDate,
      'type': oldTransaction.type,
    });
  }

  Future<void> fetchAndSetDelTransaction() async {
    final dataList = await DBHelper2.getData('delTran');
    // print(dataList);
    _historyDelete = dataList
        .map(
          (trans) => Transaction(
              id: trans['id'],
              name: trans['name'],
              amount: trans['amount'],
              description: trans['description'],
              currncy: trans['currncy'],
              oldDate: trans['oldDate'],
              newDate: trans['newDate'],
              type: trans['type']),
        )
        .toList();
  }
}
