
import 'package:convida/app/screens/deactivated_events_screen/deactivated_events_controller.dart';
import 'package:convida/app/screens/report_screen/report_controller.dart';
import 'package:convida/app/screens/reported_event_screen/reported_widget.dart';
import 'package:convida/app/shared/components/appbar_component.dart';
import 'package:convida/app/shared/components/event_card_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class DeactivatedEventsWidget extends StatefulWidget {
  @override
  _DeactivatedEventsWidgetState createState() => _DeactivatedEventsWidgetState();
}

class _DeactivatedEventsWidgetState extends State<DeactivatedEventsWidget> {
  final controller = ReportController();
  final _save = FlutterSecureStorage();
  String _token;
  String title = "Eventos Desativados";
  int screen = 7;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBarComponent(context, title: title),
      body: FutureBuilder(
          future: checkToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return ShimmerComponent(screen: screen);
            } else if (snapshot.data) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: FutureBuilder(
                    future: getDeactivatedEvents(context, _token),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Event> deactivatedEvents = snapshot.data;

                      if (snapshot.data == null) {
                        return ShimmerComponent(screen: screen);
                      } else if (snapshot.data.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "Não há eventos desativados!",
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        controller.setListItems(snapshot.data);
                        return ListView.builder(
                            itemCount: deactivatedEvents.length,
                            itemBuilder: (_, index) {
                              var event = deactivatedEvents[index];
                              return EventCard(
                                eventName: deactivatedEvents[index].name,
                                eventType: deactivatedEvents[index].type,
                                eventAddress: deactivatedEvents[index].address,
                                eventId: deactivatedEvents[index].id,
                                eventConfirmed: deactivatedEvents[index].nbmrConfirmed,
                                eventImage: deactivatedEvents[index].typeImage,
                                eventDate: deactivatedEvents[index].dateString,
                                eventStars: null,
                                onTapFunction: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RerportedEventWidget(
                                          event: event,
                                        ),
                                      )).then((value) => setState(() {}));
                                },
                              );
                            });
                      }
                    },
                  ),
                ),
              );
            } else {
              return ListView(children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Botao Entrar
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          (queryData.orientation == Orientation.portrait)
                              ? Container(
                                  height: queryData.size.height / 2.5,
                                  width: queryData.size.width / 1.2,
                                  child: Image.asset(
                                    //Image:
                                    "assets/logos/logo-ufprconvida.png",
                                    scale: 2,
                                  ),
                                )
                              : Container(
                                  height: queryData.size.height / 2.5,
                                  width: queryData.size.width / 2,
                                  child: Image.asset(
                                    //Image:
                                    "assets/logos/logo-ufprconvida.png",
                                    scale: 2,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              color: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: () async {
                                //Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushNamed("/login", arguments: "my-events")
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                              child: Text('Fazer Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      )),
                    ],
                  ),
                )
              ]);
            }
          }),
    );
  }

  Future<bool> checkToken() async {
    _token = await _save.read(key: "token");
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }
}

