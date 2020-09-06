// import 'package:flutter/material.dart';

// class AmountChange extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(20.0),
//           ),
//         ),
//         title: Text('Delete Transaction'),
//         content: Text(
//             'you try to delete Debt with this detail\n Name: ${transacts.transactoin[i].name}\n Amount: ${transacts.transactoin[i].amount}\n Description: ${transacts.transactoin[i].description}\n Currncey: ${transacts.transactoin[i].currncy}\n Date: ${transacts.transactoin[i].oldDate}\nType: ${transacts.transactoin[i].type}'),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: Text('cancel'),
//           ),
//           FlatButton(
//             onPressed: () {
//               transacts.addToDeleteHistory(
//                 transacts.transactoin[i].id,
//                 transacts.transactoin[i].name,
//                 transacts.transactoin[i].amount,
//                 transacts.transactoin[i].description,
//                 transacts.transactoin[i].currncy,
//                 transacts.transactoin[i].oldDate,
//                 transacts.transactoin[i].type,
//               );
//               transacts.addTransaction(
//                   transacts.transactoin[i].name,
//                   transacts.transactoin[i].amount,
//                   'Payment from ${transacts.transactoin[i].name}',
//                   transacts.transactoin[i].currncy,
//                   'Transaction',
//                   transacts.transactoin[i].newDate);

//               transacts.deleteTransaction(transacts.transactoin[i].id);
//               Navigator.of(context).pop();
//             },
//             child: Text('Confirm'),
//           ),
//         ],
//       ),
//     );
//   }
// }
