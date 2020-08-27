import 'package:audit/providers/transacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewTransactinos extends StatefulWidget {
  @override
  _NewTransactinosState createState() => _NewTransactinosState();
}

class _NewTransactinosState extends State<NewTransactinos> {
  @override
  Widget build(BuildContext context) {
    final _priceFocusNode = FocusNode();
    final _descriptionFocusNode = FocusNode();
    final _currFocusNode = FocusNode();
    final _nameController = TextEditingController();
    final _descController = TextEditingController();
    final _amountController = TextEditingController();
    final _currController = TextEditingController();
    final _form = GlobalKey<FormState>();

    @override
    void dispose() {
      _nameController.dispose();
      _descController.dispose();
      _amountController.dispose();
      _currController.dispose();

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
              'you try to add a new Transaction with this detail\n Name: ${_nameController.text}\n Amount: ${_amountController.text}\n Description: ${_descController.text}\n Currncey: ${_currController.text}\n Date: ${DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now())}\nType: Transaction'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('cancel'),
            ),
            FlatButton(
              onPressed: () {
                Provider.of<Transacts>(context, listen: false).addTransaction(
                  _nameController.text,
                  double.parse(_amountController.text),
                  _descController.text,
                  _currController.text,
                  'Transaction',
                  DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now()),
                );
                _nameController.text = '';
                _amountController.text = '';
                _descController.text = '';
                _currController.text = '';
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
              maxLines: 1,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_currFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Description.';
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Currncy'),
              controller: _currController,
              focusNode: _currFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Currncy.';
                return null;
              },
            ),
            RaisedButton(
              onPressed: () {
                _saveTransaction();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add),
                  Text('Add Transaction'),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '.',
                  style: TextStyle(
                    fontSize: 100,
                    color: Color.fromRGBO(0, 14, 89, 1),
                  ),
                ),
                Text(
                  '.',
                  style: TextStyle(fontSize: 100, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
