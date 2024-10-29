import 'package:flutter/material.dart';
import 'package:haca_review_main/controllers/provider/admin_issue_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Issuedetails extends StatelessWidget {
  const Issuedetails(
      {super.key,
      required this.discription,
      required this.index,
      required this.status});

  final String discription;
  final int index;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isSmallScreen = constraints.maxWidth < 600;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'asset/images/haca.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 0 : 40,
                        right: isSmallScreen ? 0 : 40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      // Adjust height for small screens
                      width: double.infinity, // Full width for all screen sizes

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isSmallScreen
                            ? _buildMobileLayout(status: status, index: index)
                            : _buildDesktopLayout(index, status),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout({required String status, required int index}) {
    return Consumer<AdminIssueProvider>(
      builder: (context, adminIssueProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 50,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, size: 30),
                  onSelected: (String value) {
                    if (value == 'Home') {
                      // Navigate to Home
                    } else if (value == 'Logout') {
                      // Perform logout
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Home', 'Logout'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Admin',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Issue Details',
              style: TextStyle(
                color: HexColor('#015AFF'),
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Name :',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem Ipsum Lorem',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'LoremIpsum@gmail.com',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text(
                  'Category :',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Lorem Ipsum Lorem',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black, width: .5),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    adminIssueProvider.complaints[index].description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10),
            child: Container(
              height: 45,
              width: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: Colors.black,
                  width: .5,
                ),
              ),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(7),
                underline: const SizedBox(),

                // Set the current value of the dropdown as the complaint's current status
                value: adminIssueProvider.complaints[index]
                    .status, // This should always reflect the complaint's current status

                onChanged: (String? newValue) {
                  if (newValue != null) {
                    // Update the status locally to reflect the change in the UI immediately
                    adminIssueProvider.updateStatusLocally(index, newValue);

                    // Optionally, send the new status to the backend
                    adminIssueProvider.updateComplaintStatusInDatabase(
                        adminIssueProvider.complaints[index].indexno.toString(),
                        newValue);
                  }
                },

                // Map the available statuses (Resolved, Ongoing, Pending) to dropdown items
                items: adminIssueProvider.statuses
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 2),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == 'Resolved'
                              ? Colors.green
                              : value == 'Ongoing'
                                  ? Colors.orange
                                  : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      // Add your onTap functionality here
                    },
                    child: Container(
                      height: 50,
                      width: 505,
                      decoration: BoxDecoration(
                        color: HexColor('#015AFF'),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Communicate',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(int index, String discription) {
    return Consumer<AdminIssueProvider>(
      builder: (context, adminIssueProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: HexColor('#015AFF'),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 100),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: HexColor('#595959'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Welcome,',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Admin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Issue Details',
              style: TextStyle(
                color: HexColor('#015AFF'),
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Name :',
                  style: TextStyle(fontSize: 13),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adminIssueProvider.complaints[index].user.name
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        adminIssueProvider.complaints[index].user.email,
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Text(
                  'Category :',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 10),
                Text(
                  adminIssueProvider.complaints[index].category,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 50, right: 50),
            child: Container(
              height: 180,
              width: 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black, width: .5),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Text(
                  adminIssueProvider.complaints[index].description,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Container(
                  height: 45,
                  width: 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Colors.black,
                      width: .5,
                    ),
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(7),
                    underline: const SizedBox(),

                    // Set the current value of the dropdown as the complaint's current status
                    value: adminIssueProvider.complaints[index]
                        .status, // This should always reflect the complaint's current status

                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        // Update the status locally to reflect the change in the UI immediately
                        adminIssueProvider.updateStatusLocally(index, newValue);

                        // Optionally, send the new status to the backend
                        adminIssueProvider.updateComplaintStatusInDatabase(
                            adminIssueProvider.complaints[index].indexno
                                .toString(),
                            newValue);
                      }
                    },

                    // Map the available statuses (Resolved, Ongoing, Pending) to dropdown items
                    items: adminIssueProvider.statuses
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 2),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: value == 'Resolved'
                                  ? Colors.green
                                  : value == 'Ongoing'
                                      ? Colors.orange
                                      : Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 50),
                child: GestureDetector(
                  onTap: () {
                    // Add your onTap functionality here
                    _sendEmail(context);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: HexColor('#015AFF'),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        'Communicate',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _sendEmail(context) async {
    final provider = Provider.of<AdminIssueProvider>(context, listen: false);
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: provider.complaints[index].user.email,
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Issue Submission Replay',
        'body': 'Issue :${provider.complaints[index].title} \n'
            'Issue discription: ${provider.complaints[index].description}\n'
            '\nDear ${provider.complaints[index].user.name.toUpperCase()}'
      }),
    );

    try {
      await launchUrl(Uri.parse(emailLaunchUri.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email client opened successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open email client: $error')),
      );
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
