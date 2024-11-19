// import 'package:flutter/material.dart';

// class NextPage extends StatelessWidget {
//   final List<String> fields; // List of fields to show
//   final int currentIndex; // Current index of the field

//   const NextPage({Key? key, required this.fields, required this.currentIndex})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final String currentField = fields[currentIndex];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Field ${currentIndex + 1} of ${fields.length}'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 currentField,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: currentIndex + 1 < fields.length
//                     ? () {
//                         // Navigate to the next page with the next field
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NextPage(
//                               fields: fields,
//                               currentIndex: currentIndex + 1,
//                             ),
//                           ),
//                         );
//                       }
//                     : null, // Disable if no more fields
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   currentIndex + 1 < fields.length ? 'Next' : 'Done',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
