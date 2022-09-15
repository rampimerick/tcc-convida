import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import 'package:convida/app/shared/global/constants.dart';

class MapWidget extends StatefulWidget {
  final Map filters;

  MapWidget({
    Key key,
    this.filters,
  }) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState(filters);
}

class _MapWidgetState extends State<MapWidget> {
  Map filters;
  _MapWidgetState(this.filters);

  MapType _mapType;
  bool showingBar = false;
  // Completer<GoogleMapController> _controller = Completer();
  //GoogleMapController mapController;
  Map<MarkerId, Marker> markersMaps = <MarkerId, Marker>{};
  String _url = kURL;
  var randID = Uuid();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  final DateFormat date = new DateFormat("d MMM yyyy", "pt_BR");
  final DateFormat dateShort = new DateFormat("d MMM yy", "pt_BR");
  final DateFormat day = new DateFormat("d", "pt_BR");
  final DateFormat month = new DateFormat("MMM", "pt_BR");
  final DateFormat year = new DateFormat("yy", "pt_BR");

  bool loadingCompleted;

  void initState() {
    super.initState();
    _mapType = MapType.normal;
    loadingCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    //setState(() {});
    return FutureBuilder(
        future: _getCurrentUserLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //Google's Map:
                _googleMap(
                    context, snapshot.data.latitude, snapshot.data.longitude),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                    child: FloatingActionButton(
                      mini: true,
                      child: Icon(Icons.add, size: 32),
                      backgroundColor: kPrimaryColor,
                      onPressed: () async {
                        //Create a random lat lng for new the event:
                        var rng = new Random();
                        int intLat = rng.nextInt(150000) + 430000;
                        int intLng = rng.nextInt(30000) + 340000;
                        double randLat = intLat / 10000000;
                        double randLng = intLng / 10000000;
                        double lat = 25.4 + randLat;
                        double lng = 49.2 + randLng;

                        final _save = FlutterSecureStorage();
                        String _token = await _save.read(key: "token");

                        if (_token == null) {
                          _showDialog("Necessário estar logado!",
                          "Somente se você estiver logado será possível criar eventos, para isso, crie uma conta ou entre com seu login!");
                        } else {
                          Navigator.pushReplacementNamed(context, "/new-event",
                              arguments: LatLng(-lat, -lng));
                        }
                      },
                    ),
                  ),
                  /*Navigator.pushReplacementNamed(context, "/new-event",
              arguments: latLng);*/
                ),

                //Search Text Field:
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.fromLTRB(8.0, 40, 8, 8),
                //           child: RaisedButton(
                //             padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                //             child: Text(
                //               "Pesquisar Endereço",
                //               maxLines: 1,
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 20.0,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             onPressed: () {
                //               showDialog(
                //                   context: context,
                //                   builder: (BuildContext context) {
                //                     return AlertDialog(
                //                       title: new Text(
                //                           "Função em desenvolvimento!"),
                //                       content: new Text(
                //                           "Infelizmente ainda não conseguimos desenvolver totalmente essa funcionalidade."),
                //                       actions: <Widget>[
                //                         // usually buttons at the bottom of the dialog
                //                         new FlatButton(
                //                           child: new Text("Ok"),
                //                           onPressed: () {
                //                             Navigator.pop(context);
                //                           },
                //                         ),
                //                       ],
                //                     );
                //                   });
                //             },
                //             color: kPrimaryColor,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                /*
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Color(secondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrganizationWidget(
                                healthType: healthType,
                                sportType: sportType,
                                partyType: partyType,
                                //onlineType: onlineType,
                                artType: artType,
                                faithType: faithType,
                                studyType: studyType,
                                othersType: othersType,
                                dataType: dataType,
                              ),
                            ));
                      },
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                      child: Text('Filtrar e Organizar',
                          maxLines: 1,
                          //kPrimaryColor,(secondaryColor)
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
                */
              ],
            );
          }
        });
  }

  Widget _googleMap(BuildContext context, double lat, double lng) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: _mapType,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: true,
          initialCameraPosition:
          CameraPosition(target: LatLng(lat, lng), zoom: 14),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onLongPress: (latlng) async {
            final _save = FlutterSecureStorage();
            String _token = await _save.read(key: "token");
            if (_token == null) {
              _showDialog("Necessário estar logado!",
                  "Somente se você estiver logado será possível criar eventos, para isso, crie uma conta ou entre com seu login!");
            } else {
              mapController = await _controller.future;
              mapController?.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(latlng.latitude, latlng.longitude),
                      zoom: 21.0)));
              //Max zoom is 21!
              //String id = _markerConfirm(latlng);
              String id = "";
              _confirmEvent(latlng, id, context);
            }
          },
          //If not completed:
          markers: Set<Marker>.of(markersMaps.values),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            //top: 110
            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
            child: FloatingActionButton(
              heroTag: 2,
              onPressed: () async {
                mapController = await _controller.future;
                LocationData currentLocation;
                var location = new Location();
                try {
                  currentLocation = await location.getLocation();
                } on Exception {
                  currentLocation = null;
                }

                //print(currentLocation);

                if (currentLocation != null) {
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 0,
                      target: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      zoom: 16.0,
                    ),
                  ));
                } else {
                  LatLng ufprLocation = new LatLng(-25.4269032, -49.2639545);

                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 0,
                      target:
                          LatLng(ufprLocation.latitude, ufprLocation.longitude),
                      zoom: 16.0,
                    ),
                  ));
                }
              },
              mini: true,
              child: Icon(Icons.my_location),
              backgroundColor: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Future<LatLng> _getCurrentUserLocation() async {
    markersMaps = await getMarkers(context);
    try {
      // Tuturial Disabled
      // if (!showingBar){
      //   showTutorialBar();
      // }

      Location location = new Location();

      bool _serviceEnabled;
      bool _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          final LatLng ufprLocation = new LatLng(-25.4269032, -49.2639545);
          return ufprLocation;
        }
      }

      PermissionStatus _permissionGrantedd = (await location.hasPermission());

      if (_permissionGrantedd == PermissionStatus.GRANTED){
        _permissionGranted = true;
      }else{
        _permissionGranted = false;
      }
      if (!_permissionGranted) {
        _permissionGranted = (await location.requestPermission()) as bool;
        if (!_permissionGranted) {
          final LatLng ufprLocation = new LatLng(-25.4269032, -49.2639545);
          return ufprLocation;
        }
      }

      _locationData = await location.getLocation();

      LatLng userLocation = new LatLng(_locationData.latitude, _locationData.longitude);
      return userLocation;
    } catch (e) {
      final String errorLocation = "Ocorreu um erro ao tentar resgatar a localização definida.";
      showError("Erro de localização", "$errorLocation", context);
      final LatLng ufprLocation = new LatLng(-25.4269032, -49.2639545);
      return ufprLocation;
    }
  }

  void showTutorialBar() {
    showingBar = true;
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.fromLTRB(10, 16, 10, 0),
      borderRadius: 8,
      backgroundColor: Colors.white,
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3)
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text(
          "Pressione por alguns segundos no mapa para criar um evento!",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
      duration: Duration(seconds: 5),
    )..show(context);
  }

  Future<Map<MarkerId, Marker>> getMarkers(BuildContext context) async {
    ////print(
    //    "Type: |$healthType|\nType: |$sportType|\nType: |$partyType|\nType: |$artType|\nType: |$studyType|\nType: |$othersType|");

    //Uri.encodeFull const's:
    String parsedHealthType;
    String parsedSportType;
    String parsedPartyType;
    String parsedArtType;
    String parsedFaithType;
    String parsedStudyType;
    String parsedOthersType;

    if (filters['healthType']) parsedHealthType = 'Sa%C3%BAde%20e%20Bem-estar';
    if (filters['sportType']) parsedSportType = 'Esporte%20e%20Lazer';
    if (filters['partyType'])
      parsedPartyType = 'Festas%20e%20Comemora%C3%A7%C3%B5es';
    if (filters['artType']) parsedArtType = 'Arte%20e%20Cultura';
    if (filters['faithType']) parsedFaithType = 'F%C3%A9%20e%20Espiritualidade';
    if (filters['studyType'])
      parsedStudyType = 'Acad%C3%AAmico%20e%20Profissional';
    if (filters['othersType']) parsedOthersType = 'Outros';

    if (!filters['healthType']) parsedHealthType = 'X';
    if (!filters['sportType']) parsedSportType = 'X';
    if (!filters['partyType']) parsedPartyType = 'X';
    if (!filters['artType']) parsedArtType = 'X';
    if (!filters['faithType']) parsedFaithType = 'X';
    if (!filters['studyType']) parsedStudyType = 'X';
    if (!filters['othersType']) parsedOthersType = 'X';

    //Tratar os erros quando todos sao null ou todos preenchidos. (Organization Screen)
    if ((filters['healthType']) &&
        (filters['sportType']) &&
        (filters['partyType']) &&
        (filters['artType']) &&
        (filters['faithType']) &&
        (filters['studyType']) &&
        (filters['othersType'])) {
      parsedHealthType = "%20";
    } else if ((!filters['healthType']) &&
        (!filters['sportType']) &&
        (!filters['partyType']) &&
        (!filters['artType']) &&
        (!filters['faithType']) &&
        (!filters['studyType']) &&
        (!filters['othersType'])) {
      parsedHealthType = "%20";
    }

    String requisition;

    //!Arrumar as requisições:
    //"$_url/events/multtype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType&text7=$parsedOnlineType";
    if (filters['dataTypeWeek']) {
      requisition =
          "$_url/events/weektype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType";
    } else if (filters['dataTypeDay']) {
      requisition =
          "$_url/events/todaytype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType";
    } else
      requisition =
          "$_url/events/multtype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType";

    var response;
    Map<MarkerId, Marker> mrks = <MarkerId, Marker>{};

    //*Create a marker because if something went wrong this marker returns
    var idZero = randID.v1();
    MarkerId markerZeroId = MarkerId("$idZero");
    Marker markerZero = Marker(
      markerId: markerZeroId,
      draggable: false,
      position: LatLng(-25.4202491, -49.2645976),
      infoWindow:
          InfoWindow(title: "UFPR Convida", snippet: "Não existem eventos"),
      icon: BitmapDescriptor.defaultMarker,
    );

    try {
      response = await http.get(Uri.parse(requisition));

      //print(" >> ------------------------------------------------------- <<");
      //print("$requisition");
      //print("Status Code: ${response.statusCode}");
      //print("Loading Event's Markers...");
      //print(" >> ------------------------------------------------------- <<");

      var jsonEvents;

      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        jsonEvents = json.decode(response.body);

        MarkerId markerId;
        LatLng location;
        //print("Loading event's markers..");
        for (var e in jsonEvents) {
          var id = randID.v1();
          ////print("markedID: $id");
          markerId = MarkerId("$id");

          location = LatLng(e["lat"], e["lng"]);
          double color;
          String type = e["type"];

          //Marker color:
          if (type == "Saúde e Bem-estar") {
            color = 0.0; //Vermelho
          } else if (type == "Esporte e Lazer") {
            color = 120.0; //Verde
          } else if (type == "Festas e Comemorações") {
            color = 270.0; //Roxo
          } else if (type == "Online") {
            color = 170.0; //Ciano
          } else if (type == "Arte e Cultura") {
            color = 300.0; //Rosa
          } else if (type == "Fé e Espiritualidade") {
            color = 60.0; //Amarelo
          } else if (type == "Acadêmico e Profissional") {
            color = 225.0; //Azul
          } else {
            color = 30.0; //Laranja
          }

          String nameLimited = e["name"];
          if (nameLimited.length >= 30) {
            nameLimited = nameLimited.substring(0, 30) + " ...";
          }

          String dateString;
          DateTime dateStart = DateTime.parse(e['dateStart']);
          DateTime dateEnd = DateTime.parse(e['dateEnd']);
          //Same Day
          if ((dateStart) == (dateEnd)) {
            dateString = date.format(dateStart);
          }
          //Same Month
          else if (month.format(dateStart) == month.format(dateEnd)) {
            dateString = "${day.format(dateStart)}-${date.format(dateEnd)}";
          }
          //Same Year
          else if (year.format(dateStart) == year.format(dateEnd)) {
            dateString =
                "${day.format(dateStart)} ${month.format(dateStart)} - ${day.format(dateEnd)} ${month.format(dateEnd)} ${year.format(dateEnd)}";
          } else {
            dateString =
                "${dateShort.format(dateStart)} - ${dateShort.format(dateEnd)}";
          }

          Marker marker = Marker(
              markerId: markerId,
              draggable: false,
              position: location,
              // RZR
              // Mostra só 30 caracteres
              infoWindow: InfoWindow(
                  title: nameLimited, snippet: "Data do Evento: $dateString"),
              icon: BitmapDescriptor.defaultMarkerWithHue(color),
              onTap: () {
                // RZR
                // Mostra só 30 caracteres
                _showSnackBar(e["name"], e["id"], context);
              });

          mrks[markerId] = marker;
        }
      } else if (response.statusCode == 401) {
        showError("Erro 401", "Não autorizado, favor logar novamente", context);
        mrks[markerZeroId] = markerZero;
      } else if (response.statusCode == 404) {
        showError("Erro 404", "Evento não foi encontrado", context);
        mrks[markerZeroId] = markerZero;
      } else if (response.statusCode == 500) {
        showError(
            "Erro 500",
            "Erro no servidor, favor tente novamente mais tarde (Map)",
            context);
        mrks[markerZeroId] = markerZero;
      } else {
        showError(
            "Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
        mrks[markerZeroId] = markerZero;
      }
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
      mrks[markerZeroId] = markerZero;
    }
    return mrks;
  }

  void _showSnackBar(String eventName, String eventId, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.fromLTRB(10, 16, 10, 0),
      borderRadius: 8,
      backgroundColor: Colors.white,

      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3)
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text("Evento: $eventName",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
      //message: "E",
      mainButton: FlatButton(
        child: Text("Visualizar"),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/event',
              arguments: {'id': eventId});
        },
      ),
      duration: Duration(seconds: 5),
    )..show(context);
  }

  void _confirmEvent(LatLng latLng, String id, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.fromLTRB(10, 16, 10, 0),
      borderRadius: 8,
      backgroundColor: Colors.white,
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3)
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text("Deseja criar um evento aqui?",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
      mainButton: FlatButton(
        child: Text("Sim"),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/new-event",
              arguments: latLng);
          ////print("Removendo marker: $id");
          //markers.remove(id);
        },
      ),
      duration: Duration(seconds: 8),
    )..show(context);
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Login"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
            /* new FlatButton(
              child: new Text("Criar conta"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "/signup");
              },
            ), */
          ],
        );
      },
    );
  }
}
