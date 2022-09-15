import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEventWidget extends StatefulWidget {
  final double lat;
  final double lng;
  MapEventWidget({this.lat, this.lng});
  @override
  _MapEventWidgetState createState() => _MapEventWidgetState();
}

class _MapEventWidgetState extends State<MapEventWidget> {

  

  @override
  Widget build(BuildContext context) {
    MarkerId markerId = MarkerId("eventLocation");
    final Marker marker =
        Marker(markerId: markerId, position: LatLng(widget.lat, widget.lng), infoWindow: InfoWindow(title: "Localização do Evento", snippet: "Rua..."));
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{
      markerId : marker
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Localização do Evento"),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 16),
            markers: Set.of(markers.values),
      ),
    );
  }
}
