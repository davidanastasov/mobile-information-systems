import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mis_lab_04/domain/event.dart';
import 'package:mis_lab_04/services/event_service.dart';

class EventsMap extends StatefulWidget {
  const EventsMap({super.key});

  @override
  State<EventsMap> createState() => _EventsMapState();
}

class _EventsMapState extends State<EventsMap> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(42.002551955700376, 21.408650067808264),
    zoom: 15.5,
  );

  late GoogleMapController _googleMapController;
  final Set<Marker> _markers = {};

  late List<Event> events;

  @override
  void initState() {
    super.initState();

    var eventsList = EventService.getEvents();

    for (var event in eventsList) {
      _markers.add(Marker(
        markerId: MarkerId(event.name),
        position: LatLng(event.latitude, event.longitude),
        infoWindow: InfoWindow(
          onTap: () =>
              Navigator.pushNamed(context, '/details', arguments: event.id),
          title: event.name,
          snippet:
              '${event.location}, ${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
        ),
      ));
    }

    setState(() {
      events = eventsList;
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Мапа"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: _markers,
      ),
    );
  }
}
