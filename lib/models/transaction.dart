import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String name;
  final double amount;
  final String description;
  final String currncy;
  final DateTime oldDate;
  final DateTime newDate;
  final String type;

  Transaction({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.description,
    @required this.currncy,
    @required this.oldDate,
    @required this.newDate,
    @required this.type,
  });
}
