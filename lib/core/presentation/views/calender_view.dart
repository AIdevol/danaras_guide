import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/core/presentation/controller/calander_view_controller.dart';
import 'package:banaras_guide/helper/circle_centric_design.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderView extends GetView<CalanderViewController> {
  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<CalanderViewController>(
        init: CalanderViewController(),
        builder: (controller) => Scaffold(
          backgroundColor: appColor,
          body: Stack(
            children: [
              // Background circles
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ConcentricCircles(),
              ),
              
              // Calendar container
              Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                left: 16,
                right: 16,
                bottom: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SfCalendar(
                      view: CalendarView.month,
                      showNavigationArrow: true,
                      backgroundColor: Colors.white,
                      headerStyle: CalendarHeaderStyle(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appColor,
                        ),
                      ),
                      monthViewSettings: MonthViewSettings(
                        showAgenda: true,
                        agendaStyle: AgendaStyle(
                          backgroundColor: Colors.white,
                          appointmentTextStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          todayTextStyle: TextStyle(
                            fontSize: 14,
                            color: appColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      todayHighlightColor: appColor,
                      selectionDecoration: BoxDecoration(
                        color: appColor.withOpacity(0.2),
                        border: Border.all(color: appColor, width: 1),
                        shape: BoxShape.circle,
                      ),
                      onTap: (CalendarTapDetails details) {
                        if (details.targetElement == CalendarElement.calendarCell) {
                          controller.onDateSelected(details.date!);
                        }
                      },
                      dataSource: _getCalendarDataSource(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CalendarDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    // Add your appointments here
    // Example:
    appointments.add(
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
        subject: 'Meeting',
        color: appColor,
      ),
    );
    return MeetingDataSource(appointments);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}