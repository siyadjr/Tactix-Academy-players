import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class PaymentSuccessPage extends StatelessWidget {
 final String rentFee;
  const PaymentSuccessPage({super.key, required this.rentFee});

  @override
  Widget build(BuildContext context) {
    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[900]!,
              Colors.black,
            ],
            stops: const [0.2, 0.9],
          ),
        ),
        child: Stack(
          children: [
            // Background particle effect
            Positioned.fill(
              child: CustomPaint(
                painter: ParticlePainter(),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon with glow effect
                  FadeInDown(
                    preferences: const AnimationPreferences(
                      offset: Duration(milliseconds: 800),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 120,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Success Message
                  FadeInUp(
                    preferences: const AnimationPreferences(
                      offset: Duration(milliseconds: 1000),
                    ),
                    child: const Text(
                      'Payment Successful!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Amount
                  ZoomIn(
                    preferences: const AnimationPreferences(
                      offset: Duration(milliseconds: 1200),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '₹$rentFee',
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Transaction Status
                  SlideInUp(
                    preferences: const AnimationPreferences(
                      offset: Duration(milliseconds: 1400),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Transaction Secured',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for background particle effect
class ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw some particles
    for (var i = 0; i < 50; i++) {
      final x = (i * size.width / 50);
      final y = (i * size.height / 50);
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
