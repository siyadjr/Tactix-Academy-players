// attendance_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/attedance_details_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_date_session.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_empty_widget.dart';
import 'package:tactix_academy_players/view/Attendance/Widget/attendance_stats_card.dart';

class AttendanceDetails extends StatelessWidget {
  const AttendanceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AttendanceDetailsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchAllAttendance();
    });

    return CustomScaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Attendance Records',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Consumer<AttendanceDetailsProvider>(
        builder: (context, attendanceProvider, child) {
          if (attendanceProvider.isLoading) {
            return const LoadingIndicator();
          }

          if (attendanceProvider.attendedDates.isEmpty &&
              attendanceProvider.absentDates.isEmpty) {
            return const EmptyAttendanceView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AttendanceStatsCard(
                  attended: attendanceProvider.attendedDates.length,
                  absent: attendanceProvider.absentDates.length,
                ),
                const SizedBox(height: 24),
                AttendanceDateSection(
                  title: "Present",
                  dates: attendanceProvider.attendedDates,
                  iconData: Icons.check_circle,
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 24),
                AttendanceDateSection(
                  title: "Absent",
                  dates: attendanceProvider.absentDates,
                  iconData: Icons.cancel,
                  iconColor: Colors.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
