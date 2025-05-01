import 'package:flutter/material.dart';
import 'package:flutter_simple/core/constants/route_constants.dart';
import 'package:go_router/go_router.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});


  @override
  Widget build(BuildContext context) {
    void onBookingItemSelected() {
      // Handle menu item selection
      print('Selected menu item:');
      context.push(RouteConstants.booking);
    }

    void onTrainingSelected() {
      // Handle training item selection
      print('Selected training item:');
      context.push(RouteConstants.training);
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: onBookingItemSelected,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text('Menu'),
            )
        ),
        ElevatedButton(
          onPressed: onTrainingSelected,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text('Training'),
            )
        ),
      ],
    );
  }
}
