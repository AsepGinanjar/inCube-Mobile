// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  // Using FlutterFlow utility function to handle icon color
  Color getIconColor(int index) {
    return _selectedIndex == index
        ? FlutterFlowTheme.of(context).primaryText
        : FlutterFlowTheme.of(context).secondaryText;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Example: Navigate to different pages or call a custom function
      FFAppState().navigateToIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Floating Navbar Example",
          style: FlutterFlowTheme.of(context).title1,
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
      body: Center(
        child: Text(
          "Selected Index: $_selectedIndex",
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: getIconColor(0)),
                  onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: getIconColor(1)),
                  onPressed: () => _onItemTapped(1),
                ),
                SizedBox(width: 50), // Space for the floating action button
                IconButton(
                  icon: Icon(Icons.bar_chart, color: getIconColor(2)),
                  onPressed: () => _onItemTapped(2),
                ),
                IconButton(
                  icon: Icon(Icons.person, color: getIconColor(3)),
                  onPressed: () => _onItemTapped(3),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            child: FloatingActionButton(
              onPressed: () => _onItemTapped(4),
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              child: Icon(Icons.shield,
                  color: FlutterFlowTheme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
