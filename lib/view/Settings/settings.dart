import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Center(
      child: Text('Settings'),
    ));
  }
}
