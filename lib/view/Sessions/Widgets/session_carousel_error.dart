import 'package:flutter/material.dart';

class SessionCarouselError extends StatelessWidget {
  const SessionCarouselError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Please Try again'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  (context as Element).markNeedsBuild();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
