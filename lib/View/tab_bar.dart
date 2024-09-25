import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/issuepage.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  String _selectedButton = 'Home';
  Color defaultColor = Colors.black;
  Color selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = MediaQuery.of(context).size.height;
          
          if (screenWidth < 600) {
            // Mobile Layout
            return _buildMobileLayout(screenHeight);
          } else if (screenWidth < 1024) {
            // Tablet Layout
            return _buildTabletLayout(screenHeight);
          } else {
            // Desktop Layout
            return _buildDesktopLayout(screenHeight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(double screenHeight) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.1,
              child: PopupMenuButton<String>(
                icon: Icon(Icons.menu, size: 35),
                onSelected: (String value) {
                  _handleMenuSelection(value);
                },
                itemBuilder: (BuildContext context) {
                  return {'Home', 'My Issues', 'Log Out'}
                      .map((String choice) {
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
      ],
    );
  }

  Widget _buildTabletLayout(double screenHeight) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.1,
              width: 400, // Adjust width for tablet
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildTabButtons(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double screenHeight) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.1,
              width: 600, // Adjust width for desktop
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildTabButtons(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildTabButtons() {
    return [
      InkWell(
        child: Text(
          'Home',
          style: TextStyle(
            color: _selectedButton == 'Home' ? selectedColor : defaultColor,
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
            ),
          );
        },
      ),
      InkWell(
        child: Text(
          'My Issues',
          style: TextStyle(
            color: _selectedButton == 'My Issues' ? selectedColor : defaultColor,
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
              builder: (context) => IssuePage(),
            ),
          );
        },
      ),
      InkWell(
        child: Text(
          'Log Out',
          style: TextStyle(
            color: _selectedButton == 'Log Out' ? selectedColor : defaultColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedButton = 'Log Out';
          });
        },
      ),
    ];
  }

  void _handleMenuSelection(String value) {
    if (value == 'Home') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else if (value == 'My Issues') {
      setState(() {
        _selectedButton = 'My Issues';
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IssuePage(),
        ),
      );
    } else if (value == 'Log Out') {
      setState(() {
        _selectedButton = 'Log Out';
      });
    }
  }
}