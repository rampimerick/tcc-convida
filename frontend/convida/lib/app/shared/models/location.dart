
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  String _end;
  String _description;
  LatLng _coords;
  
  Location (this._end,this._description,this._coords);

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get end => _end;

  set end(String value) {
    _end = value;
  }

  LatLng get coords => _coords;

  set coords(LatLng value) {
    _coords = value;
  }

}