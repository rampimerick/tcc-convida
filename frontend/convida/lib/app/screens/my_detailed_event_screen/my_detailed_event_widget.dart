import 'package:convida/app/screens/detailed_event_screen/detailed_event_widget.dart';
import 'package:convida/app/screens/list_confirmed_users_screen/list_confirmed_widget.dart';
import 'package:convida/app/screens/map_event_screen/map_event_screen_widget.dart';
import 'package:convida/app/screens/my_detailed_event_screen/my_detailed_event_controller.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/screens/alter_event_screen/alter_event_widget.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:url_launcher/url_launcher.dart';





class MyDetailedEventWidget extends StatefulWidget {

  @override
  _MyDetailedEventWidgetState createState() => _MyDetailedEventWidgetState();

}



class _MyDetailedEventWidgetState extends State<MyDetailedEventWidget> {

  final DateFormat formatter = new DateFormat.yMd("pt_BR").add_Hm();
  final DateFormat hour = new DateFormat.Hm();
  final DateFormat date = new DateFormat("d MMM yyyy", "pt_BR");
  final DateFormat dateShort = new DateFormat("d MMM yy", "pt_BR");
  final DateFormat day = new DateFormat("d", "pt_BR");
  final DateFormat month = new DateFormat("MMM", "pt_BR");
  final DateFormat year = new DateFormat("yy", "pt_BR");
  final DateFormat dateSub = new DateFormat.MMMMEEEEd("pt_BR");
  final DateFormat test = new DateFormat.MMMM("pt_BR");
  String address =
      "R. Dr. Alcides Vieira Arcoverde, 1225 - Jardim das Américas, Curitiba - PR, 81520-260";

  bool fav = false;
  User eventAuthor;
  //Color _eventColor;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final eventId = routeArgs['id'];

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double containerHeight;

    if (queryData.size.height < 500) {
      if (queryData.orientation == Orientation.portrait) {
        containerHeight = queryData.size.height / 7.5;
      } else {
        containerHeight = queryData.size.height / 4.5;
      }
    } else {
      containerHeight = queryData.size.height / 10;
    }

    return FutureBuilder(
        future: getMyEvent(eventId, context),
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot)  {
          if (snapshot.data == null) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            Event event = snapshot.data;
            DateTime dateStart = DateTime.parse(event.dateStart);
            DateTime dateEnd = DateTime.parse(event.dateEnd);
            DateTime hourStart = DateTime.parse(event.hrStart);
            DateTime hourEnd = DateTime.parse(event.hrEnd);
            DateTime subStart;
            DateTime subEnd;

            if (event.startSub != null) {
              subStart = DateTime.parse(event.startSub);
              subEnd = DateTime.parse(event.endSub);
            }

            String _imageAsset = "";

            return FutureBuilder(
                future: getAuthor(event.author, context),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot)  {
                  if (snapshot.data == null){
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }else {
                    eventAuthor = snapshot.data;
                    return Scaffold(
                        resizeToAvoidBottomInset: false,
                        backgroundColor: event.typeColor,
                        body: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: CustomScrollView(
                                slivers: <Widget>[
                                  SliverAppBar(
                                    automaticallyImplyLeading: false,
                                    leading: Navigator.canPop(context)
                                        ? Container(
                                      margin: EdgeInsets.all(8.0),
                                      //width: 40,
                                      //height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: kPrimaryColor,
                                          //size: 47,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    )
                                        : null,
                                    expandedHeight: (queryData.size.height *
                                        0.4),
                                    flexibleSpace: FlexibleSpaceBar(
                                      background: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Image.asset(event.typeImage,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    /*iconTheme: IconThemeData(
                                color: kPrimaryColors,
                              ),*/
                                    centerTitle: true,
                                    pinned: true,
                                    floating: true,
                                    elevation: 0.0,
                                    actions: [
                                      event.active == true
                                          ? Container(
                                        margin: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.checklist,
                                              color: kPrimaryColor,
                                            ),
                                            onPressed: () {
                                              print(event.id);
                                              _modalBottomSheet(context, event);
                                              //  Navigator.of(context)
                                              //      .push(
                                              //      MaterialPageRoute(
                                              //          builder: (context) =>  ListConfirmedUsersWidget(),
                                              //      )
                                              //  ).then((value) => setState(() {}));
                                            }),
                                      )
                                          : Container(),
                                    ],
                                  ),
                                  SliverList(
                                    //itemExtent: queryData.size.height,
                                    delegate: SliverChildListDelegate(
                                      [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 18, horizontal: 12),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .vertical(
                                                top: Radius.circular(20),
                                              ),
                                              color: Colors.white,
                                            ),
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: (queryData.size
                                                            .width *
                                                            0.5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  0.0),
                                                              child: Text(
                                                                  "${event.name}",
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: 10),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: <
                                                                    Widget>[
                                                                  //Endereço:
                                                                  event.online
                                                                      ? Text(
                                                                    "Evento Online",
                                                                    style:
                                                                    TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15,
                                                                      color: Color(
                                                                          0xFF737373),
                                                                    ),
                                                                  )
                                                                      : Container(),
                                                                  Text(
                                                                    "Por ${eventAuthor.name} ${eventAuthor.lastName}",
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 15,
                                                                      color: Color(
                                                                          0xFF737373),
                                                                    ),
                                                                  ),
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                    Axis.horizontal,
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                          Icons.email,
                                                                          size: 15,
                                                                          color: Color(
                                                                              0xFF737373),
                                                                        ),
                                                                        SizedBox(
                                                                            width: 5),
                                                                        Text("${eventAuthor.email}",
                                                                          maxLines: 1,
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              color: Color(0xFF737373)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                                          //width: (queryData.size.width * 0.3),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(
                                                                color: kPrimaryColor,
                                                                width: 1.5),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                dateStart == dateEnd
                                                                    ? "${date.format(dateStart)}"
                                                                    : month.format(dateStart) == month.format(dateEnd)
                                                                    ? "${day.format(dateStart)}-${date.format(dateEnd)}"
                                                                    : year.format(dateStart) == year.format(dateEnd)
                                                                    ? "${day.format(dateStart)} ${month.format(dateStart)} - ${day.format(dateEnd)} ${month.format(dateEnd)} ${year.format(dateEnd)}"
                                                                    : "${dateShort.format(dateStart)} - ${dateShort.format(dateEnd)}",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: kPrimaryColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2.0,
                                                              ),
                                                              Text(
                                                                "${hour.format(hourStart)} - ${hour.format(hourEnd)}",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: kPrimaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Text(
                                                    "${event.desc}",
                                                    style: TextStyle(
                                                      color: Color(0xFF737373),
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 30),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      event.address !=
                                                          null
                                                          ? SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Local: ',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${event.address} ",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF737373),
                                                              ),
                                                            ),
                                                            event.online
                                                                ? Container()
                                                                : Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left:
                                                                  5),
                                                              child:
                                                              EventTypeBadge(
                                                                color: Colors
                                                                    .black,
                                                                text:
                                                                "Ver no mapa",
                                                                image:
                                                                "assets/icons/map.png",
                                                                onPressed:
                                                                    () {
                                                                  //Test:
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          MapEventWidget(
                                                                            lat:event.lat,
                                                                            lng:
                                                                            event.lng,
                                                                          ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                          : Container(),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Tipo de Evento: ',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15,
                                                                //color: Color(0xFF737373),
                                                              ),
                                                            ),
                                                            EventTypeBadge(
                                                              color: event
                                                                  .typeColor,
                                                              text: event.type,
                                                              image: event
                                                                  .typeIcon,
                                                              onPressed: () {},
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(top: 4),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                Axis.horizontal,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                        'Público Alvo: ',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            color: Colors
                                                                                .black)),
                                                                    Text(
                                                                      "${event.target}",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF737373)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 8),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Link: ',
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 15,
                                                                  //color: Color(0xFF737373),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                  child: Text(
                                                                      "${event.link}",
                                                                      style: TextStyle(
                                                                          fontSize: 15,
                                                                          color: Colors
                                                                              .blueAccent)),
                                                                  onTap: () =>
                                                                      openLink(event.link)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      event.startSub !=
                                                          null
                                                          ? Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            top: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                Axis.horizontal,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      subStart ==
                                                                          subEnd
                                                                          ? "Inscreva-se em ${date
                                                                          .format(
                                                                          subStart)}."
                                                                          : month
                                                                          .format(
                                                                          subStart) ==
                                                                          month
                                                                              .format(
                                                                              subEnd)
                                                                          ? "Inscreva-se de ${day
                                                                          .format(
                                                                          subStart)} a ${date
                                                                          .format(
                                                                          subEnd)}."
                                                                          : year
                                                                          .format(
                                                                          subStart) ==
                                                                          year
                                                                              .format(
                                                                              subEnd)
                                                                          ? "Inscreva-se de ${day
                                                                          .format(
                                                                          subStart)} ${month
                                                                          .format(
                                                                          subStart)} a ${date
                                                                          .format(
                                                                          subEnd)}."
                                                                          : "Inscreva-se de ${date
                                                                          .format(
                                                                          subStart)} a ${date
                                                                          .format(
                                                                          subEnd)}.",
                                                                      style:
                                                                      TextStyle(
                                                                        color:
                                                                        kPrimaryColor,
                                                                        fontSize:
                                                                        18,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                          : Container(),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              height: getHeight(9),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            DateTime yesterday = DateTime.now()
                                                .subtract(Duration(hours: 24));

                                            if ((yesterday.compareTo(dateEnd)) >
                                                0) {
                                              //If the event ended:
                                              _showError("Evento Finalizado",
                                                  "Não é possível alterar mais esse evento, pois ele já foi encerrado!");
                                            } else {
                                              //If doesn't end, User can edit:
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AlterEventWidget(
                                                          event: event,
                                                        ),
                                                  ));
                                            }
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(top: 0.0),
                                                child: Icon(
                                                    Icons.event_note, size: 26),
                                              ),
                                              Text("Alterar")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () async {
                                            int delete = _confirmDelete(context,
                                                event.id,
                                                event.name);
                                            if (delete == 1) {
                                              int status =
                                              await deleteMyEvent(
                                                  event.id, context);
                                              if (status == 200) {
                                                Navigator.pop(context);
                                                //Navigator.pop(context);
                                                // Navigator.popAndPushNamed(
                                                //     context, '/main');
                                              } else
                                                _showWarning();
                                            }
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Icon(Icons.delete_forever,
                                                  size: 26),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(top: 0.0),
                                                child: Text("Deletar"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            )
                          ],
                        )
                    );}

              }
            );
          }
        });
  }

  // Future<User> getAuthor(String a) async {
  //   int statusCodeUser;
  //
  //   Map<String, String> mapHeaders = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //   };
  //
  //   User author;
  //   try {
  //     author = await http
  //         .get(Uri.parse("$_url/users/$a"), headers: mapHeaders)
  //         .then((http.Response response) {
  //       statusCodeUser = response.statusCode;
  //       if (statusCodeUser == 200 || statusCodeUser == 201) {
  //        // print("Author Sucess!");
  //         return User.fromJson(jsonDecode(response.body));
  //       } else if (statusCodeUser == 401) {
  //         showError(
  //             "Erro 401", "Não autorizado, favor logar novamente", context);
  //         return null;
  //       } else if (statusCodeUser == 404) {
  //         showError("Erro 404", "Autor não foi encontrado", context);
  //         return null;
  //       } else if (statusCodeUser == 500) {
  //         showError("Erro 500",
  //             "Erro no servidor, favor tente novamente mais tarde", context);
  //         return null;
  //       } else {
  //         showError(
  //             "Erro Desconhecido", "StatusCode: $statusCodeUser", context);
  //         return null;
  //       }
  //     });
  //   } catch (e) {
  //     showError("Erro desconhecido", "Erro: $e", context);
  //     return null;
  //   }
  //
  //   return author;
  // }
  //
  // Future<Event> getMyEvent(eventId) async {
  //   var response;
  //   try {
  //     response = await http.get(Uri.parse("$_url/events/$eventId"));
  //     var jsonEvent;
  //     if ((response.statusCode == 200) || (response.statusCode == 201)) {
  //       jsonEvent = json.decode(response.body);
  //       Event e = Event.fromJson(jsonEvent);
  //       eventAuthor = await getAuthor(e.author);
  //       if (eventAuthor != null) {
  //         return parseEvent(response.body);
  //       } else {
  //         showError(
  //             "Erro ao carregar evento",
  //             "Infelizmente não foi possível carregar esse evento, tente novamente mais tarde",
  //             context);
  //         return e;
  //       }
  //     } else if (response.statusCode == 401) {
  //       showError("Erro 401", "Não autorizado, favor logar novamente", context);
  //       return null;
  //     } else if (response.statusCode == 404) {
  //       showError("Erro 404", "Autor não foi encontrado", context);
  //       return null;
  //     } else if (response.statusCode == 500) {
  //       // showError("Erro 500",
  //       //     "Erro no servidor, favor tente novamente mais tarde (AQUI)", context);
  //       return null;
  //     } else {
  //       showError(
  //           "Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
  //       return null;
  //     }
  //   } catch (e) {
  //     if (e.toString().contains("at character 1")) {
  //       return null;
  //     } else {
  //       showError("Erro desconhecido ao deletar!", "Erro: $e", context);
  //       return null;
  //     }
  //   }
  // }
  //
  // Future<int> deleteMyEvent(eventId) async {
  //   final _save = FlutterSecureStorage();
  //   String _token = await _save.read(key: "token");
  //
  //   Map<String, String> mapHeaders = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     HttpHeaders.authorizationHeader: "Bearer $_token"
  //   };
  //   var response;
  //   try {
  //     response = await http.delete(Uri.parse("$_url/events/$eventId"),
  //         headers: mapHeaders);
  //     print("Deletando: $_url/events/$eventId");
  //     int statusCode = response.statusCode;
  //     print("StatusCode DEL:$statusCode");
  //     return response.statusCode;
  //   } catch (e) {
  //     showError("Erro desconhecido", "Erro: $e", context);
  //     return 500;
  //   }
  // }

  void _showError(String title, String content) {
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
          ],
        );
      },
    );
  }

  int _confirmDelete(BuildContext _context, String eventId, String eventName) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Deletar Evento"),
          content:
              new Text("Deseja realmente deletar o evento \"$eventName\"?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () =>
              {
                deleteMyEvent(eventId, _context),
                Navigator.of(_context).pop()

              }
            ),
            new FlatButton(
              child: new Text("Não"),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return 0;
  }

  void _showWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Erro ao deletar Evento"),
          content: new Text(
              "Não foi possível deletar esse evento, por favor, tente mais tarde."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/main");
              },
            ),
          ],
        );
      },
    );
  }

  openLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      showError("Impossível abrir o link",
          "Não foi possível abrir esse link: $link", context);
    }
  }
}

void _modalBottomSheet(context, event) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ConfirmedListWidget(event: event);
    },
  );

}
/*
Expanded(
                      flex: 10,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                              expandedHeight: 250.0,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Padding(
                                  padding: const EdgeInsets.only(top: 70),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12.0, top: 12),
                                    child: Image.asset("assets/$_imageAsset",
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              backgroundColor: _eventColor,
                              centerTitle: true,
                              title: Text("${snapshot.data.name}"),
                              pinned: true,
                              floating: true),
                          SliverFixedExtentList(
                            itemExtent: 165.0,
                            delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: SizedBox(
                                        width: 360,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 3, 8, 3),
                                              child: Text(
                                                  "${snapshot.data.name}",
                                                  style: TextStyle(
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: SizedBox(
                                        width: 360,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(3, 3, 3, 3),
                                                    child: Icon(
                                                        Icons.access_time,
                                                        size: 24),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Expanded(
                                                    child: Text(
                                                      "${date.format(dateStart)} - ${date.format(dateEnd)}",
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      41, 0, 0, 0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                      "${hour.format(hourStart)} - ${hour.format(hourEnd)}",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ],
                                              ),
                                            ),

                                            //Endereço:
                                            snapshot.data.online
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(11, 8, 0, 0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.wifi,
                                                            size: 24),
                                                        SizedBox(width: 6),
                                                        Expanded(
                                                          child: Text(
                                                              "Este evento é Online"),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 8, 0, 0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.location_on,
                                                            size: 28),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Text(
                                                                "${snapshot.data.address} - ${snapshot.data.complement}"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //Description
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: SizedBox(
                                        width: 360,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 8, 0),
                                              child: Text("Descrição do evento",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: SizedBox(
                                                  width: 360,
                                                  child: Text(
                                                    "${snapshot.data.desc}",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SizedBox(
                                          width: 360,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 12),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 4, 4),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Tipo de Evento: ",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "${snapshot.data.type}",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              SizedBox(height: 3),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 4, 4),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Público alvo: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                            "${snapshot.data.target}",
                                                            style: TextStyle(
                                                                fontSize: 15))
                                                      ],
                                                    ),
                                                  )),
                                              SizedBox(height: 3),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 4, 4),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Link: ",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        InkWell(
                                                            child: Text(
                                                                "${snapshot.data.link}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontSize:
                                                                        15)),
                                                            onTap: () =>
                                                                openLink(
                                                                    snapshot
                                                                        .data
                                                                        .link))
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                  alignment: Alignment.center,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: 360,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 6, 8, 2),
                                            child: Text("Contato",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.person, size: 28),
                                                SizedBox(width: 7),
                                                Text(
                                                    "${eventAuthor.name} ${eventAuthor.lastName}",
                                                    maxLines: 1,
                                                    style:
                                                        TextStyle(fontSize: 15))
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.email, size: 28),
                                                SizedBox(width: 7),
                                                Text(
                                                  "${eventAuthor.email}",
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                snapshot.data.startSub != null
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: SizedBox(
                                              width: 360,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 8, 8, 0),
                                                    child: Text("Inscrições:",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 4, 4, 4),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    3, 3, 3, 3),
                                                            child: Icon(
                                                                Icons.timer,
                                                                size: 24),
                                                          ),
                                                          SizedBox(width: 3),
                                                          Text("Início: ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(width: 3),
                                                          Expanded(
                                                            child: Text(
                                                                "${dateSub.format(subStart)}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0)),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 4, 4, 4),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    3, 3, 3, 3),
                                                            child: Icon(
                                                                Icons.timer_off,
                                                                size: 24),
                                                          ),
                                                          SizedBox(width: 3),
                                                          Text("Fim: ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(width: 3),
                                                          Expanded(
                                                            child: Text(
                                                                "${dateSub.format(subEnd)}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0)),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: SizedBox(
                                              width: 360,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 8, 8, 0),
                                                    child: Text(
                                                        "Não há inscrições",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                      width: 360,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 14, 4, 4),
                                                        child: Text(
                                                            "Infelizmente o organizador não informou datas de inscrições",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .grey)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
*/

