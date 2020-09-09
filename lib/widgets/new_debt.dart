import 'package:audit/admob/ad_manager.dart';
import 'package:audit/providers/transacts.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewDebt extends StatefulWidget {
  @override
  _NewDebtState createState() => _NewDebtState();
}

class _NewDebtState extends State<NewDebt> {
  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;

  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      default:
        _loadInterstitialAd();
    }
  }

  @override
  void initState() {
    _isInterstitialAdReady = false;
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
  }

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _currFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _currController = TextEditingController();
  final _dateController = TextEditingController(
      text: '${DateFormat("yyyy-MM-dd").format(DateTime.now())}');

  final _form = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _amountController.dispose();
    _currController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String currncy = 'USD';
  @override
  Widget build(BuildContext context) {
    void _saveTransaction(String type) {
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
          title: Text('New $type'),
          content: Text(
              'you try to add a new $type with this detail\n Name: ${_nameController.text}\n Amount: ${_amountController.text}\n Description: ${_descController.text}\n Currncey: $currncy\n Date: $selectedDate\nType: $type'),
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
                    currncy,
                    '$type',
                    selectedDate.toString());

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

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                  primary: const Color.fromRGBO(0, 14, 89, 1)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
      );

      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
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
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                _loadInterstitialAd();
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
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                _loadInterstitialAd();
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
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                _loadInterstitialAd();
                FocusScope.of(context).requestFocus(_currFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please enter a Description.';
                return null;
              },
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),

            DropdownButton<String>(
              value: currncy,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 1,
                color: Colors.grey[400],
              ),
              onChanged: (String newValue) {
                setState(() {
                  currncy = newValue;
                });
              },
              items: <String>['USD', 'ILS', 'EUR', 'CHF', 'MAD', 'JPY']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // TextFormField(
            //   textInputAction: TextInputAction.next,
            //   decoration: InputDecoration(labelText: 'Currncy'),
            //   controller: _currController,
            //   focusNode: _currFocusNode,
            //   onFieldSubmitted: (_) {
            //     FocusScope.of(context).requestFocus(_dateFocusNode);
            //   },
            //   validator: (value) {
            //     if (value.isEmpty) return 'Please enter a Currncy.';
            //     return null;
            //   },
            // ),
            // TextFormField(
            //   textInputAction: TextInputAction.next,
            //   decoration: InputDecoration(labelText: 'Date yy-mm-dd'),
            //   controller: _dateController,
            //   focusNode: _dateFocusNode,
            //   keyboardType: TextInputType.datetime,
            //   onFieldSubmitted: (_) {
            //     FocusScope.of(context).requestFocus(FocusNode());
            //   },
            //   validator: (value) {
            //     if ((value).isEmpty)
            //       return 'Please enter a Date yy/mm/dd\nExample 2020-01-01.';
            //     return null;
            //   },
            // ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Text("${selectedDate.toLocal()}".split(' ')[0]),
            ),
            Divider(height: 20, color: Colors.grey),
            SizedBox(
              height: 20.0,
            ),
            // RaisedButton(
            //   onPressed: () {
            //     _selectDate(context);
            //   },
            //   child: Text('Select date'),
            // ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              onPressed: () {
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                _loadInterstitialAd();

                _saveTransaction('Debt');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                  ),
                  Text('Add Debt'),
                  Padding(
                    padding: EdgeInsets.only(right: 55),
                  ),
                ],
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                _loadInterstitialAd();

                _saveTransaction('Transaction');
              },
              icon: Icon(Icons.add),
              label: Text('Add Transaction'),
            ),
            SizedBox(
              height: 23,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       '.',
            //       style: TextStyle(fontSize: 100, color: Colors.grey),
            //     ),
            //     Text(
            //       '.',
            //       style: TextStyle(
            //         fontSize: 100,
            //         color: Color.fromRGBO(0, 14, 89, 1),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
