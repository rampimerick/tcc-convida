import 'package:convida/app/screens/my_confirmed_events_screen/my_confirmed_controller.dart';
import 'package:convida/app/shared/components/event_card_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/global/constants.dart';

class ConfirmedWidget extends StatefulWidget {
  @override
  _ConfirmedWidgetState createState() => _ConfirmedWidgetState();
}

class _ConfirmedWidgetState extends State<ConfirmedWidget> {
  var jsonData;
  DateFormat date = new DateFormat.yMMMMd("pt_BR");
  DateFormat hour = new DateFormat.Hm();
  String _token, _userId;
  final _save = FlutterSecureStorage();
  int screen = 3;

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
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == null) {
              return ShimmerComponent(screen: screen);
            } else if (snapshot.data) {
              return Container(
                child: Center(
                  child: FutureBuilder(
                    future: getAllMyConfirmedEvents(context, _token, _userId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Event> confirmedEvents = snapshot.data;
                      if (snapshot.data == null || snapshot.connectionState != ConnectionState.done) {
                        return ShimmerComponent(screen: screen);
                      } else if (confirmedEvents.isEmpty|| confirmedEvents.length == 0) {
                        //Caso nao houver eventos!
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Ainda não existem eventos em que você confirmou presença",
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
                                    "Para confirmar presença em um evento, basta visualizar detalhadamente o evento e pressionar o botão Confirmar Presença.",
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
                                    Navigator.of(context)
                                        .pushReplacementNamed("/main");
                                  },
                                  padding: EdgeInsets.fromLTRB(43, 12, 43, 12),
                                  child: Text('Ir aos Eventos',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: confirmedEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EventCard(
                                eventDate: confirmedEvents[index].dateString,
                                eventName: confirmedEvents[index].name,
                                eventType: confirmedEvents[index].type,
                                eventStars: confirmedEvents[index].nbmrFavorites,
                                eventImage: confirmedEvents[index].typeImage,
                                onTapFunction: () {
                                  Navigator.pushNamed(context, '/event',
                                      arguments: {
                                        'id': confirmedEvents[index].id
                                      }).then((value) {
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
                                  "assets/logos/logo-ufprconvida.png",
                                  scale: 2,
                                ),
                              )
                                  : Container(
                                height: queryData.size.height / 2.5,
                                width: queryData.size.width / 2,
                                child: Image.asset(
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
                                    Navigator.pushNamed(context, "/login",
                                        arguments: "fav")
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                  padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                                  child: Text(
                                    'Fazer Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          )),
                    ],
                  ),
                ),
              ]);
            }
          }),
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
