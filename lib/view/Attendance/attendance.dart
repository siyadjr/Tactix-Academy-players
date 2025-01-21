import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/attendance_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_details_container.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_punch_button.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_punched.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_time_over.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/no_attendance_day.dart';

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchAttendance();
    });

    return CustomScaffold(
      appBar: AppBar(
        title: FadeInDown(
          child: const Text(
            'Mark your Attendance',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AttendanceProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? const Center(child: LoadingIndicator())
                  : SizedBox(
                      height: double.infinity,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: buildAttendanceStatus(
                                          context, provider)),
                                  const SizedBox(height: 20),
                                  provider.isLoading
                                      ? const SizedBox()
                                      : AttendanceDetailsContainer(
                                          context: context)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAttendanceStatus(
      BuildContext context, AttendanceProvider provider) {
    final todayAttendance = provider.todaysAttendance;

    if (todayAttendance == null || todayAttendance.isEmpty) {
      return const NoAttendanceDay();
    }

    if (provider.punched) {
      return const AttendancePunched();
    }

    if (provider.isTimeOver) {
      return const AttendanceTimeOver();
    }

    return AttendancePunchButton(provider: provider);
  }
}
