import 'package:convida/app/screens/favorites_screen/favorites_controller.dart';
import 'package:convida/app/shared/components/event_card_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/global/constants.dart';


enum WhyFarther { Link, Favoritar, Mapa }

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  var jsonData;
  DateFormat date = new DateFormat.yMMMMd("pt_BR");
  DateFormat hour = new DateFormat.Hm();
  String _token, _userId;
  final _save = FlutterSecureStorage();
  int screen = 1;

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
                    future: getAllFavoriteEvents(context, _token, _userId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Event> favoriteEvents = snapshot.data;
                      if (snapshot.data == null &&
                          snapshot.connectionState != ConnectionState.done) {
                        return ShimmerComponent(screen: screen);
                      } else if (favoriteEvents.length == 0) {
                        //Sem eventos!
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Ainda não existem eventos favoritados por você",
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
                                    "Para favoritar um evento, basta visualizar detalhadamente o evento e pressionar na estrela que estará branca, então ela ficará amarela indicando que o evento foi favoritado com sucesso",
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
                            itemCount: favoriteEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EventCard(
                                eventDate: favoriteEvents[index].dateString,
                                eventName: favoriteEvents[index].name,
                                eventType: favoriteEvents[index].type,
                                // eventIcon: favoriteEvents[index].typeIcon,
                                // eventIconColor: favoriteEvents[index].typeColor,
                                eventImage: favoriteEvents[index].typeImage,
                                eventStars: favoriteEvents[index].nbmrFavorites,
                                onTapFunction: () {
                                  Navigator.pushNamed(context, '/event',
                                      arguments: {
                                        'id': favoriteEvents[index].id
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
                                Navigator.pushNamed(context, "/login",
                                        arguments: "fav")
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
                                //When press Signup:
                                //Navigator.of(context).pop();
                                // Navigator.push(context, SlideRightRoute(page: AboutWidget()));
                                Navigator.of(context)
                                    .pushNamed("/signup", arguments: "fav");
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
//
// class EventCard extends StatelessWidget {
//   const EventCard(
//       {Key key,
//       @required this.eventIcon,
//       @required this.eventIconColor,
//       @required this.eventImage,
//       @required this.eventName,
//       @required this.eventType,
//       @required this.eventDate,
//       @required this.eventStars,
//       @required this.onTapFunction})
//       : super(key: key);
//
//   final String eventIcon;
//   final Color eventIconColor;
//   final String eventImage;
//   final String eventName;
//   final String eventType;
//   final String eventDate;
//   final int eventStars;
//   final Function onTapFunction;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: getHeight(16),
//         child: Padding(
//             padding: EdgeInsets.fromLTRB(getMediumPadding(), getSmallPadding(),
//                 getMediumPadding(), getSmallPadding()),
//             child: InkWell(
//               onTap: onTapFunction,
//               child: LayoutBuilder(builder: (_, constraints) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               bottomLeft: Radius.circular(10)),
//                           color: Colors.grey.shade100,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(getSmallPadding()),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10.0),
//                             child: Image.asset(eventImage,
//                                 height: constraints.maxHeight,
//                                 fit: BoxFit.fitHeight),
//                           ),
//                         )),
//                     Expanded(
//                       child: Container(
//                         height: constraints.maxHeight,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10),
//                               bottomRight: Radius.circular(10)),
//                           color: Colors.grey.shade100,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(getMediumPadding()),
//                           child: Column(
//                             children: [
//                               //Title
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: TextTitle(
//                                       text: eventName,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               //Date
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: TextDescription(text: eventDate),
//                                   )
//                                 ],
//                               ),
//                               Spacer(),
//                               //Stars
//                               Row(
//                                 children: [
//                                   Icon(Icons.star,
//                                       size: 8, color: Colors.grey.shade700),
//                                   //If Event > 9999
//                                   Expanded(
//                                     child: TextDescription(
//                                         text: eventStars.toString()),
//                                   ),
//                                 ],
//                               ),
//                               //Type
//                               Row(children: [
//                                 Expanded(
//                                   child: TextDescription(
//                                     text: eventType,
//                                   ),
//                                 )
//                               ]),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               }),
//             )));
//   }
// }
