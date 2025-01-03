import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/controllers/provider/user_issue_get_provider.dart';
import 'package:haca_review_main/models/user_issue_get_model.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({super.key});

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  String _selectedButton = 'My Issues';
  Color defaultColor = Colors.black;
  Color selectedColor = Colors.blue;

  late Future<List<UserIssue>> futureIssues;

  @override
  void initState() {
    super.initState();
    // Fetch the data when the screen initializes
    futureIssues = Provider.of<UserIssueGetProvider>(context, listen: false)
        .fetchUserIssues();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine crossAxisCount based on screen width
    int crossAxisCount = screenWidth < 600 ? 1 : 3;

    // Set dynamic font sizes based on screen width
    double titleFontSize = screenWidth < 600 ? 24 : 48;
    double subtitleFontSize = screenWidth < 600 ? 18 : 24;
    double cardPadding = screenWidth < 600 ? 10 : 16;
    double gridSpacing = screenWidth < 600 ? 0 : 16;
    double aspectRatio = screenWidth < 600 ? 8 / 7 : 12 / 7;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
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
                                    builder: (context) => Home(),
                                  ));
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

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const IssuePage()));
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
                              dialogCoolBuilder(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    builder: (context) => const Home()));
                          } else if (value == 'Myissue') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const IssuePage()));
                          } else if (value == 'Logout') {
                            dialogCoolBuilder(context);
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
          screenWidth > 600
              ? Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Student',
                        style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(height: screenWidth < 600 ? 12 : 20),
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Text(
              'My Issues',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: screenWidth < 600 ? 12 : 20),
          Expanded(
            child: FutureBuilder<List<UserIssue>>(
              future: futureIssues,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading indicator while data is being fetched
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Show a message when there are no issues
                  return Center(child: Text('No issues found.'));
                } else if (snapshot.hasError) {
                  // Show error message if something goes wrong
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Data is successfully fetched
                  List<UserIssue> issues = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50),
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: gridSpacing,
                      mainAxisSpacing: gridSpacing,
                      childAspectRatio: aspectRatio,
                      children: List.generate(issues.length, (index) {
                        UserIssue issue = issues[index];
                        String formattedDate =
                            DateFormat('dd MMM yyyy').format(issue.createdAt);

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  screenWidth < 600 ? 6.0 : 8.0),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(cardPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Issue ${index + 1}:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  screenWidth > 600 ? 18 : 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            issue.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  screenWidth < 600 ? 18 : 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Category:',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 171, 170, 170),
                                                fontSize:
                                                    screenWidth < 600 ? 16 : 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            issue.category,
                                            style: TextStyle(
                                                fontSize:
                                                    screenWidth < 600 ? 16 : 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Date:',
                                            style: TextStyle(
                                              fontSize:
                                                  screenWidth < 600 ? 16 : 14,
                                              color: const Color.fromARGB(
                                                  255, 171, 170, 170),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formattedDate,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenWidth < 600
                                                    ? 16
                                                    : 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'School:',
                                            style: TextStyle(
                                              fontSize:
                                                  screenWidth < 600 ? 16 : 14,
                                              color: const Color.fromARGB(
                                                  255, 171, 170, 170),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            issue.school,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenWidth < 600
                                                    ? 16
                                                    : 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Batch:',
                                            style: TextStyle(
                                              fontSize:
                                                  screenWidth < 600 ? 16 : 14,
                                              color: const Color.fromARGB(
                                                  255, 171, 170, 170),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            issue.batch,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenWidth < 600
                                                    ? 16
                                                    : 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Status: ',
                                            style: TextStyle(
                                              fontSize:
                                                  screenWidth < 600 ? 16 : 14,
                                              color: const Color.fromARGB(
                                                  255, 171, 170, 170),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            issue.status,
                                            style: TextStyle(
                                              color: issue.status == 'Pending'
                                                  ? Colors.red
                                                  : issue.status == 'Resolved'
                                                      ? Colors.green
                                                      : Colors.orange,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  screenWidth < 600 ? 12 : 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Description:',
                                            style: TextStyle(
                                              fontSize:
                                                  screenWidth < 600 ? 16 : 14,
                                              color: const Color.fromARGB(
                                                  255, 171, 170, 170),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            issue.description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenWidth < 600
                                                    ? 16
                                                    : 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: screenWidth < 600 ? 15 : 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
              },
            ),
          ),
        ],
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
                          color: const Color.fromARGB(255, 171, 170, 170),
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
                        color: const Color.fromARGB(255, 171, 170, 170),
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
                        color: const Color.fromARGB(255, 171, 170, 170),
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
