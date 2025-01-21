import 'package:flutter/material.dart';

import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class OrSignWIthGoogle extends StatelessWidget {
  const OrSignWIthGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: secondaryTextColor,
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Or sign with',
            style: TextStyle(color: secondaryTextColor),
          ),
        ),
        Expanded(
          child: Divider(
            color: secondaryTextColor,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
