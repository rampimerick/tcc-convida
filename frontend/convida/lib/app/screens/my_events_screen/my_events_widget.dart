import 'package:convida/app/shared/DAO/event_requisitions.dart';
import 'package:convida/app/shared/components/event_card_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/global/constants.dart';


class MyEventsWidget extends StatefulWidget {
  @override
  _MyEventsWidgetState createState() => _MyEventsWidgetState();
}

class _MyEventsWidgetState extends State<MyEventsWidget> {
  final _save = FlutterSecureStorage();
  var jsonData;
  DateFormat date = new DateFormat.yMMMMd("pt_BR");
  DateFormat hour = new DateFormat.Hm();
  String _token, _userId;
  int screen = 2;


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: FutureBuilder(
        future: checkToken(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return ShimmerComponent(screen: screen);

          } else if (snapshot.data) {
            return Container(
              color: Colors.white,
              child: Center(
                child: FutureBuilder(
                  future: getAllMyEvents(
                    context,
                    _token,
                    _userId,
                  ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Event> myEvents = snapshot.data;
                    if (snapshot.data == null || snapshot.connectionState != ConnectionState.done) {
                      return ShimmerComponent(screen: screen);
                    } else if (myEvents.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "Ainda não existem eventos criados por você",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "Para criar um evento, basta ir ao Mapa pressionar exatamente no local que deseja criar seu evento e esperar alguns segundos",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 48),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                onPressed: () {
                                  //When press Signup:
                                  Navigator.of(context)
                                      .pushReplacementNamed("/main");
                                },
                                padding: EdgeInsets.fromLTRB(43, 12, 43, 12),
                                child: Text('Ir aos Eventos',
                                    //kPrimaryColor,(secondaryColor)
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return EventCard(
                              eventId: myEvents[index].id,
                              eventConfirmed: null,
                              eventAddress: myEvents[index].address,
                              eventDate: myEvents[index].dateString,
                              eventName: myEvents[index].name,
                              eventType: myEvents[index].type,
                              eventStars: myEvents[index].nbmrFavorites,
                              eventImage: myEvents[index].typeImage,
                              onTapFunction: () {
                                Navigator.pushNamed(
                                        context, '/my-detailed-event',
                                        arguments: {'id': myEvents[index].id})
                                    .then((value) {
                                  setState(() {});
                                });
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
                        /* Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Color(secondaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed("/signup", arguments: "my-events");
                            },
                            padding: EdgeInsets.fromLTRB(43, 12, 43, 12),
                            child: Text('Fazer Cadastro',
                                //kPrimaryColor,(secondaryColor)
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ), */
                        SizedBox(height: 30),
                      ],
                    )),
                  ],
                ),
              )
            ]);
          }
        },
      ),
    );
  }

  Future<bool> checkToken() async {
    _token = await _save.read(key: "token");
    _userId = await _save.read(key: "userId");
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }
}
