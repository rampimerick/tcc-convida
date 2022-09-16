import 'package:convida/app/screens/detailed_event_screen/detailed_event_controller.dart';
import 'package:convida/app/shared/check_token/check_token.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:convida/app/shared/util/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/screens/map_event_screen/map_event_screen_widget.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/models/user.dart';

class DetailedEventWidget extends StatefulWidget {
  @override
  _DetailedEventWidgetState createState() => _DetailedEventWidgetState();
}

class _DetailedEventWidgetState extends State<DetailedEventWidget> {

  final DetailedEventController detailedEventController =
      DetailedEventController();

  final TextEditingController reportController = new TextEditingController();
  final DateFormat formatter = new DateFormat.yMd("pt_BR").add_Hm();
  final DateFormat hour = new DateFormat.Hm();
  final DateFormat date = new DateFormat("d MMM yyyy", "pt_BR");
  final DateFormat dateShort = new DateFormat("d MMM yy", "pt_BR");
  final DateFormat day = new DateFormat("d", "pt_BR");
  final DateFormat month = new DateFormat("MMM", "pt_BR");
  final DateFormat year = new DateFormat("yy", "pt_BR");
  final DateFormat dateSub = new DateFormat.MMMMEEEEd("pt_BR");
  final DateFormat test = new DateFormat.MMMM("pt_BR");
  String address = "";

  // bool fav;
  User eventAuthor;
  String token;

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
        future: checkTokenn(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          token = snapshot.data;
          return FutureBuilder(
              future: detailedEventController.getEvent(eventId, context),
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.data == null) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Event event = snapshot.data;
                  if (snapshot.data == null) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    DateTime dateStart = DateTime.parse(event.dateStart);
                    DateTime dateEnd = DateTime.parse(event.dateEnd);
                    DateTime hourStart = DateTime.parse(event.hrStart);
                    DateTime hourEnd = DateTime.parse(event.hrEnd);
                    DateTime subStart;
                    DateTime subEnd;
                    if (snapshot.data.startSub != null) {
                      subStart = DateTime.parse(event.startSub);
                      subEnd = DateTime.parse(event.endSub);
                    }
                    //!!Deletei, aqui setava as imagens e cores!!

                    return FutureBuilder(
                        future: detailedEventController.getAuthor(
                            event.author, context),
                        builder: (BuildContext context,
                            AsyncSnapshot<User> snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              color: Colors.white,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            eventAuthor = snapshot.data;
                            return Scaffold(
                              //It makes the page Fixed avoiding overflow when the keybord Appears
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: kPrimaryColor,
                                                      //size: 47,
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                )
                                              : null,
                                          expandedHeight:
                                              (queryData.size.height * 0.4),
                                          flexibleSpace: FlexibleSpaceBar(
                                            background: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0.0),
                                                child: Image.asset(
                                                    event.typeImage,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          /*iconTheme: IconThemeData(
                                  color: kPrimaryColors,
                                ),*/
                                          centerTitle: true,
                                          //title: Text("${snapshot.data.name}"),
                                          pinned: true,
                                          floating: true,
                                          elevation: 0.0,
                                          actions: [
                                            event.active == true
                                                ? Container(
                                                    margin: EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    child: IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .report_gmailerrorred_rounded,
                                                          color: kPrimaryColor,
                                                          //size: 47,
                                                        ),
                                                        onPressed: () {
                                                          _reportDialog(
                                                              eventId);
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
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 18,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.vertical(
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: (queryData
                                                                      .size
                                                                      .width *
                                                                  0.5),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            0.0),
                                                                    child: Text(
                                                                        "${event.name}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                10),
                                                                    child:
                                                                        Column(
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
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 15,
                                                                                  color: Color(0xFF737373),
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                        Text(
                                                                          "Por ${eventAuthor.name} ${eventAuthor.lastName}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Color(0xFF737373),
                                                                          ),
                                                                        ),
                                                                        SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Icon(
                                                                                Icons.email,
                                                                                size: 15,
                                                                                color: Color(0xFF737373),
                                                                              ),
                                                                              SizedBox(width: 5),
                                                                              Text(
                                                                                "${eventAuthor.email}",
                                                                                maxLines: 1,
                                                                                style: TextStyle(fontSize: 15, color: Color(0xFF737373)),
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
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            8.0,
                                                                        horizontal:
                                                                            10.0),
                                                                //width: (queryData.size.width * 0.3),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      width:
                                                                          1.5),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      dateStart ==
                                                                              dateEnd
                                                                          ? "${date.format(dateStart)}"
                                                                          : month.format(dateStart) == month.format(dateEnd)
                                                                              ? "${day.format(dateStart)}-${date.format(dateEnd)}"
                                                                              : year.format(dateStart) == year.format(dateEnd)
                                                                                  ? "${day.format(dateStart)} ${month.format(dateStart)} - ${day.format(dateEnd)} ${month.format(dateEnd)} ${year.format(dateEnd)}"
                                                                                  : "${dateShort.format(dateStart)} - ${dateShort.format(dateEnd)}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            kPrimaryColor,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          2.0,
                                                                    ),
                                                                    Text(
                                                                      "${hour.format(hourStart)} - ${hour.format(hourEnd)}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            kPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10.0),
                                                        child: Text(
                                                          "${event.desc}",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF737373),
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 30),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
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
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${event.address} ",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Color(0xFF737373),
                                                                          ),
                                                                        ),
                                                                        event.online
                                                                            ? Container()
                                                                            : Padding(
                                                                                padding: EdgeInsets.only(left: 5),
                                                                                child: EventTypeBadge(
                                                                                  color: Colors.black,
                                                                                  text: "Ver no mapa",
                                                                                  image: "assets/icons/map.png",
                                                                                  onPressed: () {
                                                                                    //Test:
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => MapEventWidget(
                                                                                          lat: event.lat,
                                                                                          lng: event.lng,
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
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                      //color: Color(0xFF737373),
                                                                    ),
                                                                  ),
                                                                  EventTypeBadge(
                                                                    color: event
                                                                        .typeColor,
                                                                    text: event
                                                                        .type,
                                                                    image: event
                                                                        .typeIcon,
                                                                    onPressed:
                                                                        () {},
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 8),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                              'Público Alvo: ',
                                                                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                                                                          Text(
                                                                            "${event.target}",
                                                                            style:
                                                                                TextStyle(color: Color(0xFF737373)),
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
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Link: ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            15,
                                                                        //color: Color(0xFF737373),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                        child: Text(
                                                                            "${event.link}",
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15,
                                                                                color: Colors
                                                                                    .blueAccent)),
                                                                        onTap: () => detailedEventController.openLink(
                                                                            event.link,
                                                                            context)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            event.startSub !=
                                                                    null
                                                                ? Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                20),
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
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  subStart == subEnd
                                                                                      ? "Inscreva-se em ${date.format(subStart)}."
                                                                                      : month.format(subStart) == month.format(subEnd)
                                                                                          ? "Inscreva-se de ${day.format(subStart)} a ${date.format(subEnd)}."
                                                                                          : year.format(subStart) == year.format(subEnd)
                                                                                              ? "Inscreva-se de ${day.format(subStart)} ${month.format(subStart)} a ${date.format(subEnd)}."
                                                                                              : "Inscreva-se de ${date.format(subStart)} a ${date.format(subEnd)}.",
                                                                                  style: TextStyle(
                                                                                    color: kPrimaryColor,
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500,
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
                                    height: getHeight(10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 20.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 8.0),
                                                child: SizedBox(
                                                  height: 40.0,
                                                  child: Observer(builder:
                                                      (BuildContext context) {
                                                    return RaisedButton(
                                                        onPressed: () {
                                                          if (token != null) {
                                                            detailedEventController
                                                                .presenceController(
                                                                    event.id,
                                                                    token,
                                                                    context);
                                                          } else {
                                                            _showDialog(
                                                                "Necessário estar logado!",
                                                                "Somente se você estiver logado será possível confirmar presença em eventos, para isso, entre com seu login!");
                                                          }
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40)),
                                                        child: Text(
                                                          "Confirmar Presença",
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        color: detailedEventController.presence == false
                                                            ? kPrimaryColor
                                                            : Colors.grey);
                                                  }),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (token != null) {
                                                    if (detailedEventController.favorite == true)
                                                      detailedEventController
                                                          .deleteEventFav(
                                                              event.id,
                                                              context);
                                                    else
                                                      detailedEventController
                                                          .putEventFav(event.id,
                                                              context);
                                                  } else {
                                                    _showDialog(
                                                        "Necessário estar logado!",
                                                        "Somente se você estiver logado será possível favoritar eventos, para isso, entre com seu login!");
                                                  }
                                                },
                                                child: Observer(builder:
                                                    (BuildContext context) {

                                                  return Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      //width: 32,
                                                      //height: 32,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          color: detailedEventController.favorite == false
                                                              ? kPrimaryColor
                                                              : Color(
                                                                  0xFFA0A0A0)),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            "assets/icons/favourite.png"),
                                                        size: 26,
                                                        color: Colors.white,
                                                      ));
                                                }),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                  }
                }
              });
        });
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
                //Pop the Dialog
                Navigator.pop(context);
                //Push login screen
                Navigator.of(context)
                    .pushReplacementNamed("/login", arguments: "fav");
              },
            ),
            /* new FlatButton(
              child: new Text("Criar conta"),
              onPressed: () {
                //Push sign up screen
                Navigator.of(context)
                    .pushReplacementNamed("/signup", arguments: "fav");
              },
            ), */
          ],
        );
      },
    );
  }

  _reportDialog(String eventId) {
    if (token != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Observer(builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Justificativa:"),
              content: textFieldWithoutIcon(
                  maxLines: 4,
                  onChanged: detailedEventController.setReport,
                  maxLength: 280,
                  labelText: "Justifique sua Denúncia",
                  errorText: detailedEventController.validateReport),
              actions: <Widget>[
                detailedEventController.validateReport() == null
                    ? FlatButton(
                        child: new Text("Denunciar"),
                        onPressed: () {
                          if (token != null) {
                            detailedEventController.putReport(eventId, detailedEventController.report, context);
                          } else {
                            _showDialog("Favor logar novamente!",
                                "Somente se você estiver logado será possível denunciar eventos, para isso, crie uma conta ou entre com seu login!");
                          }
                        },
                      )
                    : FlatButton(
                        child: Text("Denunciar"),
                        onPressed: null,
                      ),
                new FlatButton(
                  child: new Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        },
      );
    } else {
      _showDialog("Necessário estar logado!",
          "Somente se você estiver logado será possível denunciar eventos, para isso, crie uma conta ou entre com seu login!");
    }
  }
}

class EventTypeBadge extends StatelessWidget {
  //final String subject;
  final String text;
  final String image;
  final Color color;
  final VoidCallback onPressed;

  const EventTypeBadge(
      { //this.subject,
      this.text,
      this.image,
      this.color,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onPressed,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: color, width: 1.5)),
      label: Text(text),
      labelStyle: TextStyle(color: color),
      padding: EdgeInsets.all(4.0),
      avatar: ImageIcon(
        AssetImage(image),
        color: color,
        size: 25,
      ),
    );
  }
}
