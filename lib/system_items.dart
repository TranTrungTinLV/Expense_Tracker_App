import 'package:flutter/material.dart';

class SystemItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text('Dark'),
            onTap: () {
              // Handle dark mode
            },
          ),
          ListTile(
            title: Text('Light'),
            onTap: () {
              // Handle light mode
            },
          ),
          ListTile(
            title: Text('System'),
            onTap: () {
              // Handle system mode
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Handle profile
            },
          ),
        ],
      ),
    );
  }
}
