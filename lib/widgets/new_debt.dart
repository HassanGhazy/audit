import 'package:audit/providers/transacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewDebt extends StatefulWidget {
  @override
  _NewDebtState createState() => _NewDebtState();
}

class _NewDebtState extends State<NewDebt> {
  @override
  Widget build(BuildContext context) {
    final _priceFocusNode = FocusNode();
    final _descriptionFocusNode = FocusNode();
    final _currFocusNode = FocusNode();
    final _dateFocusNode = FocusNode();
    final _nameController = TextEditingController();
    final _descController = TextEditingController();
    final _amountController = TextEditingController();
    final _currController = TextEditingController();
    final _dateController = TextEditingController(
        text: '${DateFormat("yyyy-MM-dd").format(DateTime.now())}');

    final _form = GlobalKey<FormState>();

    @override
    void dispose() {
      _nameController.dispose();
      _descController.dispose();
      _amountController.dispose();
      _currController.dispose();
      _dateController.dispose();
      super.dispose();
    }

    void _saveTransaction() {
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: Text('New Transaction'),
          content: Text(
              'you try to add a new Transaction with this detail\n Name: ${_nameController.text}\n Amount: ${_amountController.text}\n Description: ${_descController.text}\n Currncey: ${_currController.text}\n Date: ${_dateController.text}\nType: Debt'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('cancel'),
            ),
            FlatButton(
              onPressed: () {
                Provider.of<Transacts>(context, listen: false).addTransaction(
                    _nameController.text,
                    double.parse(_amountController.text),
                    _descController.text,
                    _currController.text,
                    'Debt',
                    DateTime.parse(_dateController.text));
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Name'),
              controller: _nameController,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Name.';
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.numberWithOptions(),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Amount.';
                if (double.tryParse(value) == null)
                  return 'Please enter a valid number.';

                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Description'),
              controller: _descController,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_currFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Description.';
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Currncy'),
              controller: _currController,
              focusNode: _currFocusNode,
              // keyboardType: TextInputType.datetime,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_dateFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Currncy.';
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Date yy-mm-dd'),
              controller: _dateController,
              focusNode: _dateFocusNode,
              keyboardType: TextInputType.datetime,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                if ((value).isEmpty)
                  return 'Please enter a Date yy/mm/dd\nExample 2020-01-01.';
                return null;
              },
            ),
            RaisedButton.icon(
                onPressed: () {
                  _saveTransaction();
                },
                icon: Icon(Icons.add),
                label: Text('Add Debt')),
            SizedBox(
              height: 23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '.',
                  style: TextStyle(fontSize: 100, color: Colors.grey),
                ),
                Text(
                  '.',
                  style: TextStyle(
                    fontSize: 100,
                    color: Color.fromRGBO(0, 14, 89, 1),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}