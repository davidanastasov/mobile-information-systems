import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mis_lab_04/domain/event.dart';
import 'package:mis_lab_04/services/event_service.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late GoogleMapController _googleMapController;
  final Set<Marker> markers = {};
  late var initialCameraPosition = const CameraPosition(
    target: LatLng(41.99646, 21.43141),
    zoom: 13,
  );

  Event? event;
  int id = -1;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments;
      getDetails(id);
    }
  }

  void getDetails(int id) {
    var eventInfo = EventService.getEvent(id);

    var marker = Marker(
      markerId: MarkerId(eventInfo.name),
      position: LatLng(eventInfo.latitude, eventInfo.longitude),
      infoWindow: InfoWindow(
        title: eventInfo.name,
        snippet: eventInfo.location,
      ),
    );

    setState(() {
      event = eventInfo;
      markers.add(marker);
      initialCameraPosition = CameraPosition(
        target: LatLng(eventInfo.latitude, eventInfo.longitude),
        zoom: 14.9, // Map is not rendering properly on first load, move it to display it
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: event == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event!.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${DateFormat('HH:mm').format(event!.startTime)} - ${DateFormat('HH:mm').format(event!.endTime)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_pin, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event!.location,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    "Опис",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event!.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    "Локација",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: initialCameraPosition,
                      onMapCreated: (controller) {
                        setState(() {
                          _googleMapController = controller;
                        });

                        _googleMapController.animateCamera(
                          CameraUpdate.newLatLngZoom(
                              markers.first.position, 15.0),
                        );

                        for (var marker in markers) {
                          _googleMapController
                              .showMarkerInfoWindow(marker.markerId);
                        }
                      },
                      markers: markers,

                      // Disable gestures and interactions
                      scrollGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
