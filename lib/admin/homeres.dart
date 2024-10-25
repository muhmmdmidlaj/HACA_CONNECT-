import 'package:flutter/material.dart';
import 'package:haca_review_main/admin/contoller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'issuedetails.dart';

class Adminpage extends StatelessWidget {
  const Adminpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isSmallScreen = constraints.maxWidth <= 600;

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
                        image: AssetImage('asset/images/haca.png'),
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

                      child: isSmallScreen
                          ? _buildMobileLayout(context)
                          : _buildPcLayout(context),
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

  Widget _buildPcLayout(BuildContext context) {
    return Column(
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
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30, top: .1),
          child: Text(
            "Welcome,",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
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
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Issues',
            style: TextStyle(
              color: HexColor('#015AFF'),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<StatusProvider>(
              builder: (context, statusProvider, child) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Issuedetails(),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Issue ${index + 1}:',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Lorem Ipsum',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Student Name:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Lorem Ipsum',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Category:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Lorem Ipsum Lorem',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  overflow: TextOverflow.fade,
                                                  'Date:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  '15 July 2024',
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Status:',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                    left: 8,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 25,
                                                        width: 110,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: .5,
                                                          ),
                                                        ),
                                                        child: DropdownButton<
                                                            String>(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          underline:
                                                              const SizedBox(),
                                                          value: statusProvider
                                                                  .selectedStatuses[
                                                              index],
                                                          onChanged: (String?
                                                              newValue) {
                                                            statusProvider
                                                                .updateStatus(
                                                                    index,
                                                                    newValue!);
                                                          },
                                                          items: statusProvider
                                                              .statuses
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            2),
                                                                child: Text(
                                                                  value,
                                                                  style:
                                                                      TextStyle(
                                                                    color: value ==
                                                                            'Resolved'
                                                                        ? Colors
                                                                            .green
                                                                        : value ==
                                                                                'Ongoing'
                                                                            ? Colors.orange
                                                                            : Colors.red,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30, top: .1),
              child: Text(
                "Welcome,",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: PopupMenuButton<String>(
                icon: const Icon(Icons.menu, size: 35),
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
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ],
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
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Issues',
            style: TextStyle(
              color: HexColor('#015AFF'),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Consumer<StatusProvider>(
            builder: (context, statusProvider, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Single column for mobile
                  childAspectRatio: 8 / 4.6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Issuedetails(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Issue ${index + 1}:',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Lorem Ipsum',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Student Name:',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Lorem Ipsum',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Category:',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Lorem Ipsum Lorem',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                overflow: TextOverflow.fade,
                                                'Date:',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                '15 July 2024',
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Status:',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  left: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 95,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: .5,
                                                        ),
                                                      ),
                                                      child: DropdownButton<
                                                          String>(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        underline:
                                                            const SizedBox(),
                                                        value: statusProvider
                                                                .selectedStatuses[
                                                            index],
                                                        onChanged:
                                                            (String? newValue) {
                                                          statusProvider
                                                              .updateStatus(
                                                                  index,
                                                                  newValue!);
                                                        },
                                                        items: statusProvider
                                                            .statuses
                                                            .map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right: 2),
                                                              child: Text(
                                                                value,
                                                                style:
                                                                    TextStyle(
                                                                  color: value ==
                                                                          'Resolved'
                                                                      ? Colors
                                                                          .green
                                                                      : value ==
                                                                              'Ongoing'
                                                                          ? Colors
                                                                              .orange
                                                                          : Colors
                                                                              .red,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
