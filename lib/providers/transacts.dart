import 'package:audit/helpers/db_helper.dart';
import 'package:audit/helpers/db_helper2.dart';
import 'package:audit/helpers/db_helper3.dart';
import 'package:audit/models/pin.dart';
import 'package:audit/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Transacts with ChangeNotifier {
  List<Transaction> _transaction = [];
  List<Transaction> _historyDelete = [];
  List<Pin> _pinCode = [];
  List<Map<String, dynamic>> _totalAmountCurrency = [];
  Map<String, Iterable<Map<String, dynamic>>> currncyAndAmount = {};
  List<Transaction> get transactoin {
    return [..._transaction];
  }

  List<Transaction> get historyDelete {
    return [..._historyDelete];
  }

  List<Pin> get pinCode {
    return [..._pinCode];
  }

  List<Map<String, dynamic>> get totalAmountCurrency {
    return [..._totalAmountCurrency];
  }

  bool isTotaled = true;

  total() {
    double totalDebt = 0;
    double totalTransaction = 0;
    double maxAmountDebt = 0;
    double maxAmountTranasction = 0;
    String descrptionMaxTransaction = '';
    String currncyMaxTransaction = '';
    String currncyMaxDebt = '';

    String haveMaxDebt = '';

    for (var i = 0; i < transactoin.length; i++) {
      if (transactoin[i].type == 'Debt') {
        totalDebt += transactoin[i].amount;

        if (maxAmountDebt < transactoin[i].amount) {
          maxAmountDebt = transactoin[i].amount;
          haveMaxDebt = transactoin[i].name;
          currncyMaxDebt = transactoin[i].currncy;
        }
      } else if (transactoin[i].type == 'Transaction') {
        totalTransaction += transactoin[i].amount;
        if (maxAmountTranasction < transactoin[i].amount) {
          maxAmountTranasction = transactoin[i].amount;
          descrptionMaxTransaction = transactoin[i].description;
          currncyMaxTransaction = transactoin[i].currncy;
        }
      }
    }
    return [
      totalDebt, // 0
      totalTransaction, // 1
      maxAmountDebt, // 2
      haveMaxDebt, // 3
      maxAmountTranasction, // 4
      descrptionMaxTransaction, // 5
      currncyMaxDebt, // 6
      currncyMaxTransaction, // 7
    ];
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

    for (var i = 0; i < dataList.length; i++) {
      if (dataList[i]['type'] == 'Debt') {
        _totalAmountCurrency.add(dataList[i]);
      }
    }

    if (isTotaled) {
      final mapped = _totalAmountCurrency
          .fold<Map<String, Map<String, dynamic>>>({}, (p, v) {
        final name = v["currncy"];

        if (p.containsKey(name)) {
          p[name]["amount"] += v["amount"];
        } else {
          p[name] = {...v, "amount": v["amount"]};
        }

        return p;
      });

      final newData = {'Total': mapped.values};
      currncyAndAmount = newData;
      isTotaled = false;
    }
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

  updateTransaction(double amount, String currncy, String id) async {
    final db = await DBHelper.database();
    int result = await db.rawUpdate('''
    UPDATE transactio  
    SET amount = ?, currncy = ? 
    WHERE id = ?
    ''', [amount, currncy, id]);

    return result;
  }

  void addPinCode(String newPinCode, String newIsActive) async {
    final pin = Pin(pinCode: newPinCode, isActive: newIsActive);

    _pinCode.add(pin);
    notifyListeners();

    DBHelper3.insert('pin', {
      'pinCode': newPinCode,
      'isActive': newIsActive,
    });
  }

  Future<void> fetchAndSetPinCode() async {
    final dataList = await DBHelper3.getData('pin');
    _pinCode = dataList
        .map(
          (trans) => Pin(
            pinCode: trans['pinCode'],
            isActive: trans['isActive'],
          ),
        )
        .toList();
  }

  void deletePinCode() async {
    final db = await DBHelper3.database();
    await db.delete('pin');

    _pinCode.clear();
    notifyListeners();
  }
}
