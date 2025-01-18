import 'package:mis_lab_04/domain/event_type.dart';

class Event {
  int id;
  String name;
  String description;
  EventType type;
  DateTime startTime;
  DateTime endTime;
  String location;
  double longitude;
  double latitude;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.longitude,
    required this.latitude,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['Id'],
      name: json['Name'],
      description: json['Description'],
      type: EventType.values.byName(json['Type']),
      startTime: DateTime.parse(json['StartTime']),
      endTime: DateTime.parse(json['EndTime']),
      location: json['Location'],
      longitude: json['Longitude'],
      latitude: json['Latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'Type': type.name,
      'StartTime': startTime.toIso8601String(),
      'EndTime': endTime.toIso8601String(),
      'Location': location,
      'Longitude': longitude,
      'Latitude': latitude,
    };
  }
}
