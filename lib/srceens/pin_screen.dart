import 'package:audit/providers/transacts.dart';
import 'package:audit/srceens/detail_pin_screen.dart';
import 'package:audit/srceens/method-transaction.dart';
import 'package:audit/widgets/input_pin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinScreen extends StatefulWidget {
  static const routeName = '/pin-screen';

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> with WidgetsBindingObserver {
  Route<Object> get routeName => routeName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Navigator.of(context).pushReplacement(routeName);
      print(44444);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transacts = Provider.of<Transacts>(context);
    final _form = GlobalKey<FormState>();
    final _firstController = TextEditingController();
    final _secandFocusNode = FocusNode();
    final _thirdFocusNode = FocusNode();
    final _fourthFocusNode = FocusNode();
    final _secandController = TextEditingController();
    final _thirdController = TextEditingController();
    final _fourthontroller = TextEditingController();

    _showDialog(String message) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: Text('Error'),
          content: Text(message),
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
    }

    void _confirmPinCode() {
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();

      if (transacts.pinCode.length == 0) {
        _showDialog('you didn\'t make a pin code yet');
        return;
      }
      if (transacts.pinCode[0].pinCode ==
          '${_firstController.text}${_secandController.text}${_thirdController.text}${_fourthontroller.text}') {
        Navigator.of(context).pushReplacementNamed(MethodTransaction.routeName);
      } else {
        _showDialog('Your Pin is Not Valid');
        return;
      }
    }

    return FutureBuilder(
      future: Provider.of<Transacts>(context).fetchAndSetPinCode(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Color.fromRGBO(0, 14, 89, 1),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter your Pin Code',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(247, 78, 126, 1),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                    Form(
                      key: _form,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InputPin(TextInputAction.next, _firstController, null,
                              _secandFocusNode),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20)),
                          InputPin(TextInputAction.next, _secandController,
                              _secandFocusNode, _thirdFocusNode),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20)),
                          InputPin(TextInputAction.next, _thirdController,
                              _thirdFocusNode, _fourthFocusNode),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20)),
                          InputPin(TextInputAction.done, _fourthontroller,
                              _fourthFocusNode, FocusNode()),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    RaisedButton(
                      onPressed: () {
                        _confirmPinCode();
                      },
                      child: Text('Enter'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Create one if you don\'t have from ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(247, 78, 126, 1),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        InkWell(
                          onTap: () {
                            if (transacts.pinCode.length == 0) {
                              Navigator.of(context).pushReplacementNamed(
                                  DetailPinScreen.routeName);
                            } else {
                              _showDialog('you already have one');
                            }
                          },
                          child: Text(
                            'Here',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(200, 70, 200, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
