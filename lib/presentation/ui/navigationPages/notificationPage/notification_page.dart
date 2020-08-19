import 'package:flutter/material.dart';

import 'notification_card.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: List.generate(10, (index) => NotificationCard()),
        ),
      ),
    );
  }
}
