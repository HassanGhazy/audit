import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPin extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode foucusNodeCurrntly;
  final FocusNode foucusNodeNext;
  final TextInputAction textInputAction;

  InputPin(this.textInputAction, this.controller, this.foucusNodeCurrntly,
      this.foucusNodeNext);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromRGBO(12, 28, 101, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: controller,
        maxLength: 1,
        autofocus: true,
        onChanged: (value) {
          if (value != '') {
            FocusScope.of(context).requestFocus(foucusNodeNext);
          }
        },
        decoration: InputDecoration(
          counterText: "",
        ),
        obscureText: true,
        focusNode: foucusNodeCurrntly,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(1),
        ],
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
