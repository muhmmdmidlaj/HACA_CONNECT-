// import 'package:flutter/material.dart';

// class Issuepage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leading: Image.asset(name),
//         // title: const Text(
//         //   'HACA',
//         //   style: TextStyle(color: Colors.white),
//         // ),
//         title: Image.asset("lib/assets/HACA LOGO.png"),
//         centerTitle: true,
//         // actions: <Widget>[
//         //   // TextButton(
//         //   //   onPressed: () {},
//         //   //   child: Text('Home', style: TextStyle(color: Colors.white)),
//         //   // ),
//         //   // TextButton(
//         //   //   onPressed: () {},
//         //   //   child:
//         //   //       const Text('My Issues', style: TextStyle(color: Colors.blue)),
//         //   // ),
//         //   TextButton(
//         //     onPressed: () {},
//         //     child: Text('Log Out', style: TextStyle(color: Colors.white)),
//         //   ),
//         // ],
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Welcome,',
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               'Student',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 20),
//             const Text(
//               'My Issues',
//               style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.blue,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 16.0,
//                 childAspectRatio: 12 / 5,
//                 mainAxisSpacing: 16.0,
//                 children: List.generate(6, (index) {
//                   return IssueCard(
//                     status: index == 2
//                         ? 'Resolved'
//                         : index == 3
//                             ? 'Ongoing'
//                             : 'Pending',
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IssueCard extends StatelessWidget {
//   final String status;

//   const IssueCard({Key? key, required this.status}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Issue 1:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text('Category: Lorem Ipsum Lorem'),
//             SizedBox(height: 8),
//             Text('Date: 15 July 2024'),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Text('Status: '),
//                 Text(
//                   status,
//                   style: TextStyle(
//                     color: status == 'Pending'
//                         ? Colors.red
//                         : status == 'Resolved'
//                             ? Colors.green
//                             : Colors.orange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),

//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/logout.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';
import 'package:hexcolor/hexcolor.dart';

class IssuePage extends StatefulWidget {
  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  String _selectedButton = 'My Issues';
  Color defaultColor = Colors.black;
  Color selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    // Fetch screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine crossAxisCount based on screen width
    int crossAxisCount = screenWidth < 600 ? 1 : 3;

    // Set dynamic font sizes based on screen width
    double titleFontSize = screenWidth < 600 ? 24 : 32;
    double subtitleFontSize = screenWidth < 600 ? 18 : 24;
    double cardPadding = screenWidth < 600 ? 20 : 16;
    double gridSpacing = screenWidth < 600 ? 8 : 16;
    double aspectRatio = screenWidth < 600 ? 8 / 4.6 : 12 / 5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("asset/images/haca.png"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth < 600 ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            screenWidth > 600
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Text(
                                'Home',
                                style: TextStyle(
                                  color: _selectedButton == 'Home'
                                      ? selectedColor
                                      : defaultColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedButton = 'Home';
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                            ),
                            InkWell(
                              child: Text(
                                'My Issues',
                                style: TextStyle(
                                  color: _selectedButton == 'My Issues'
                                      ? selectedColor
                                      : defaultColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedButton = 'My Issues';
                                });
                              },
                            ),
                            InkWell(
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                  color: _selectedButton == 'Log Out'
                                      ? selectedColor
                                      : defaultColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedButton = 'Log Out';
                                });
                                dialogBuilder(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome,',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'student',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        // Menu icon aligned to the right
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.menu, size: 35),
                          onSelected: (String value) {
                            if (value == 'Home') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            } else if (value == 'Myissue') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IssuePage()));
                            } else if (value == 'Logout') {
                              Future<void> _dialogBuilder(
                                  BuildContext context) {
                                return showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Log Out'),
                                      content: const Text(
                                        'Are you sure you want to log out?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Log Out'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return {'Home', 'Myissue', 'Logout'}
                                .map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
            Text(
              'Welcome,',
              style: TextStyle(
                  fontSize: titleFontSize, fontWeight: FontWeight.w700),
            ),
            Text(
              'Student',
              style: TextStyle(
                  fontSize: subtitleFontSize, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: screenWidth < 600 ? 12 : 20),
            Text(
              'My Issues',
              style: TextStyle(
                fontSize: screenWidth < 600 ? 16 : 20,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: screenWidth < 600 ? 12 : 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: gridSpacing,
                mainAxisSpacing: gridSpacing,
                childAspectRatio: aspectRatio,
                children: List.generate(6, (index) {
                  return IssueCard(
                    status: index == 2
                        ? 'Resolved'
                        : index == 3
                            ? 'Ongoing'
                            : 'Pending',
                    padding: cardPadding,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final String status;
  final double padding;

  const IssueCard({Key? key, required this.status, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch screen width using MediaQuery for responsive adjustments
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth < 600 ? 6.0 : 8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Issue 1:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth < 600 ? 18 : 16,
                ),
              ),
              SizedBox(height: screenWidth < 600 ? 15 : 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Category:',
                      style: TextStyle(
                          color: Color.fromARGB(255, 171, 170, 170),
                          fontSize: screenWidth < 600 ? 16 : 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Lorem Ipsum Lorem:',
                      style: TextStyle(
                          fontSize: screenWidth < 600 ? 16 : 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth < 600 ? 15 : 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date:',
                      style: TextStyle(
                        fontSize: screenWidth < 600 ? 16 : 14,
                        color: Color.fromARGB(255, 171, 170, 170),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '15 July 2024',
                      style: TextStyle(fontSize: screenWidth < 600 ? 16 : 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth < 600 ? 15 : 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Status: ',
                      style: TextStyle(
                        fontSize: screenWidth < 600 ? 16 : 14,
                        color: Color.fromARGB(255, 171, 170, 170),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      status,
                      style: TextStyle(
                        color: status == 'Pending'
                            ? Colors.red
                            : status == 'Resolved'
                                ? Colors.green
                                : Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 600 ? 12 : 14,
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
