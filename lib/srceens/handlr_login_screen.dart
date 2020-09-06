// import 'package:audit/helpers/db_helper3.dart';
// import 'package:audit/providers/transacts.dart';
// import 'package:audit/srceens/method-transaction.dart';
// import 'package:audit/srceens/pin_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HandlrLoginScreen extends StatelessWidget {
//   static const routeName = '/handlr-login';
//   @override
//   Widget build(BuildContext context) {
//     final transacts = Provider.of<Transacts>(context);
//     return FutureBuilder(
//         future: Provider.of<Transacts>(context).fetchAndSetTransaction(),
//         builder: (ctx, snapshot) {
//           return snapshot.connectionState == ConnectionState.waiting
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : InkWell(
//                   child: Text('${transacts.pinCode}'),
//                   onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
//                       PinScreen.routeName, (Route<dynamic> route) => false));
//           // : Navigator.of(context).pushNamedAndRemoveUntil(
//           //     PinScreen.routeName, (Route<dynamic> route) => false);
//         });
//   }
// }
