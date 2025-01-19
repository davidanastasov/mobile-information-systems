import 'package:mis_lab_04/data/events.dart';
import 'package:mis_lab_04/domain/event.dart';

class EventService {
  static List<Event> getEvents() {
    return eventsRawData.map((json) => Event.fromJson(json)).toList();
  }

  static Event getEvent(int id) {
    return eventsRawData
        .map((json) => Event.fromJson(json))
        .firstWhere((event) => event.id == id);
  }
}
