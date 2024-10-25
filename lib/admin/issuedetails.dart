import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Issuedetails extends StatelessWidget {
  const Issuedetails({super.key});

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
                            ? _buildMobileLayout()
                            : _buildDesktopLayout(),
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

  Widget _buildMobileLayout() {
    return Column(
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
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                  style: TextStyle(fontSize: 14),
                ),
              ),
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
                    height: 30,
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
    );
  }

  Widget _buildDesktopLayout() {
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
        const Padding(
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
                      'Lorem Ipsum Lorem',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'LoremIpsum@gmail.com',
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Row(
            children: [
              Text(
                'Category :',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(width: 10),
              Text(
                'Lorem Ipsum Lorem',
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
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 50),
          child: GestureDetector(
            onTap: () {
              // Add your onTap functionality here
            },
            child: Container(
              height: 30,
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
    );
  }
}
