import 'package:audit/providers/transacts.dart';
import 'package:audit/srceens/method-transaction.dart';
import 'package:audit/widgets/input_pin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPinScreen extends StatefulWidget {
  static const routeName = '/detail-pin';
  @override
  _DetailPinScreenState createState() => _DetailPinScreenState();
}

class _DetailPinScreenState extends State<DetailPinScreen> {
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

    void _savePinCode() {
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();

      Provider.of<Transacts>(context, listen: false).addPinCode(
          '${_firstController.text}${_secandController.text}${_thirdController.text}${_fourthontroller.text}',
          '1');
      _firstController.text = '';
      _secandController.text = '';
      _thirdController.text = '';
      _fourthontroller.text = '';
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 14, 89, 1),
      appBar: AppBar(
        title: Text('Activate Pin'),
      ),
      body: FutureBuilder(
        future: Provider.of<Transacts>(context).fetchAndSetPinCode(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (transacts.pinCode.isEmpty)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Text(
                            'You need to activate Pin code \nEnter the number here',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(247, 78, 126, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Form(
                          key: _form,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InputPin(
                                  _firstController, null, _secandFocusNode),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20)),
                              InputPin(_secandController, _secandFocusNode,
                                  _thirdFocusNode),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20)),
                              InputPin(_thirdController, _thirdFocusNode,
                                  _fourthFocusNode),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20)),
                              InputPin(_fourthontroller, _fourthFocusNode,
                                  FocusNode()),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                        RaisedButton(
                          onPressed: () {
                            _savePinCode();
                            Navigator.of(context).pushReplacementNamed(
                                MethodTransaction.routeName);
                          },
                          child: Text('Save'),
                        )
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'You already Have Pin Code \nYou can remove or Change it',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(247, 78, 126, 1),
                            ),
                          ),
                          SizedBox(height: 50),

                          FlatButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  title: Text('Update Pin'),
                                  content: Text('Are you Sure ?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: Text('cancel'),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Provider.of<Transacts>(context,
                                                listen: false)
                                            .deletePinCode();

                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            color: Color.fromRGBO(12, 28, 101, 1),
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          // FlatButton(
                          //   onPressed: () {

                          //   },
                          //   color: Color.fromRGBO(12, 28, 101, 1),
                          //   child: Text(
                          //     'Update',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
