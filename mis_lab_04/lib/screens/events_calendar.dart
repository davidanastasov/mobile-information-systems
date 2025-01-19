import 'package:flutter/material.dart';
import 'package:mis_lab_04/domain/event_type.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:mis_lab_04/services/event_service.dart';
import 'package:intl/intl.dart';

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({super.key});

  @override
  State<EventsCalendar> createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
  final CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Календар"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _navigateToMapView,
            icon: const Icon(Icons.map),
          )
        ],
      ),
      body: SfCalendar(
        view: CalendarView.schedule,
        showTodayButton: true,
        showNavigationArrow: true,
        dataSource: _EventDataSource(_getDataSource()),
        firstDayOfWeek: 1,
        minDate: DateTime.now().subtract(const Duration(days: 30)),
        maxDate: DateTime.now().add(const Duration(days: 30)),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
        ),
        initialSelectedDate: DateTime.now(),
        allowedViews: const [
          CalendarView.month,
          CalendarView.day,
          CalendarView.schedule
        ],
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            final Appointment appointment = details.appointments!.first;
            _navigateToEventDetails(appointment.id);
          }
        },
        appointmentBuilder:
            (BuildContext context, CalendarAppointmentDetails details) {
          final Appointment appointment = details.appointments.first;

          if (_controller.view != CalendarView.month &&
              _controller.view != CalendarView.schedule) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: details.bounds.height,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: appointment.color,
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.subject,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.white, size: 12),
                              const SizedBox(width: 2),
                              Text(
                                '${DateFormat('HH:mm').format(appointment.startTime)} - ${DateFormat('HH:mm').format(appointment.endTime)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  color: Colors.white, size: 12),
                              const SizedBox(width: 2),
                              Text(
                                '${appointment.location}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
                ),
              ],
            );
          }

          return Text(appointment.subject);
        },
      ),
    );
  }

  void _navigateToEventDetails(Object? id) {
    Navigator.pushNamed(context, '/details', arguments: id);
  }

  void _navigateToMapView() {
    Navigator.pushNamed(context, '/map');
  }

  List<Appointment> _getDataSource() {
    final events = EventService.getEvents();

    return events.map((event) {
      return Appointment(
          id: event.id,
          startTime: event.startTime,
          endTime: event.endTime,
          subject: event.name,
          notes: event.description,
          location: event.location,
          color: _getEventColor(event.type),
          isAllDay: event.type == EventType.assignment);
    }).toList();
  }

  Color _getEventColor(EventType type) {
    switch (type) {
      case EventType.exam:
        return Colors.redAccent;
      case EventType.lab:
        return Colors.purple;
      case EventType.assignment:
        return Colors.lightBlue;
    }
  }
}

class _EventDataSource extends CalendarDataSource {
  _EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
