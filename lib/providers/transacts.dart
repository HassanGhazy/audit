import 'package:audit/helpers/db_helper.dart';
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
      String type, DateTime date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        name: name,
        amount: amount,
        description: desc,
        currncy: curr,
        oldDate: DateTime.parse(
            DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())),
        newDate: date,
        type: type);

    _transaction.add(newTransaction);
    notifyListeners();

    DBHelper.insert('transaction', {
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

  void deleteTransaction(String id) {
    final existingProductIndex =
        _transaction.indexWhere((trans) => trans.id == id);

    _transaction.removeAt(existingProductIndex);
    notifyListeners();
  }

  Future<void> fetchAndSetTransaction() async {
    final dataList = await DBHelper.getData('transaction');
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

  void addToDeleteHistory(String id, String name, double amount, String desc,
      String curr, DateTime date, String type) {
    final oldTransaction = Transaction(
      id: id,
      name: name,
      amount: amount,
      description: desc,
      currncy: curr,
      oldDate: date,
      newDate: DateTime.parse(
          DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())),
      type: type,
    );

    _historyDelete.add(oldTransaction);
    notifyListeners();
  }
}
