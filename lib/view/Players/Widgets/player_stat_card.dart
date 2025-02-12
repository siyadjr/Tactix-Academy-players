import 'package:flutter/material.dart';

import '../../../core/Theme/appcolours.dart';

class StatCard extends StatelessWidget {
  final String title, value;
  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.withOpacity(0.1),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800])),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    color: secondaryTextColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}