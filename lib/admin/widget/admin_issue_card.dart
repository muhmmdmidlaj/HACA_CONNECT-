// import 'package:flutter/material.dart';
// import 'package:haca_review_main/admin/issuedetails.dart';
// import 'package:haca_review_main/controllers/provider/admin_issue_provider.dart';
// import 'package:provider/provider.dart';

// class AdminIssueCard extends StatelessWidget {
//   AdminIssueCard({
//     super.key,
//     required this.index,
//     required this.title,
//     required this.category,
//     required this.school,
//     required this.batch,
//     required this.modeOfclass,
//     required this.discription,
//     required this.createdAt,
//     required this.name,
//     required this.email,
//   });

//   final int index;
//   final String title;
//   final String category;
//   final String school;
//   final String batch;
//   final String modeOfclass;
//   final String discription;
//   final String createdAt;
//   final String name;
//   final String email;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AdminIssueProvider>(
//       builder: (context, statusProvider, child) {
//         // Ensure the index is valid for both complaints and selectedStatuses
//         if (index >= statusProvider.selectedStatuses.length) {
//           return Container(); // Return an empty container if index is out of bounds
//         }

//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Issuedetails(
//                   discription: discription,
//                 ),
//               ),
//             );
//           },
//           child: Card(
//             elevation: 4.0,
//             margin:
//                 const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Issue Index
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Issue $index:',
//                             style: const TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             title,
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
            
//                   // Student Name
//                   buildInfoRow('Student Name:', name),
            
//                   // Category
//                   buildInfoRow('Category:', category),
            
//                   // // School
//                   // buildInfoRow('School:', school),
            
//                   // // Batch
//                   // buildInfoRow('Batch:', batch),
            
//                   // // Mode of Class
//                   // buildInfoRow('Mode of Class:', modeOfclass),
            
//                   // // Date (Created At)
//                   // buildInfoRow('Date:', createdAt),
            
//                   // Status Dropdown
//                   Row(
//                     children: [
//                       const Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             'Status:',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: buildStatusDropdown(statusProvider),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Helper method to build rows for displaying information
//   Widget buildInfoRow(String label, String value) {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//               overflow: TextOverflow.fade, // Apply overflow handling here
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Dropdown for Status
//   Widget buildStatusDropdown(AdminIssueProvider statusProvider) {
//     return Container(
//       height: 25,
//       width: 110,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(3),
//         border: Border.all(color: Colors.black, width: .5),
//       ),
//       child: DropdownButton<String>(
//         borderRadius: BorderRadius.circular(3),
//         underline: const SizedBox(),
//         value: statusProvider.selectedStatuses[index],
//         onChanged: (String? newValue) {
//           if (newValue != null) {
//             statusProvider.updateStatus(index, newValue);
//           }
//         },
//         items: statusProvider.statuses
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 2),
//               child: Text(
//                 value,
//                 style: TextStyle(
//                   color: value == 'Resolved'
//                       ? Colors.green
//                       : value == 'Ongoing'
//                           ? Colors.orange
//                           : Colors.red,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
