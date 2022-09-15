import 'package:convida/app/screens/main_screen/main_widget.dart';
import 'package:convida/app/screens/report_screen/report_controller.dart';
import 'package:convida/app/screens/reported_event_screen/reported_widget.dart';
import 'package:convida/app/shared/check_token/check_token.dart';
import 'package:convida/app/shared/components/appbar_component.dart';
import 'package:convida/app/shared/components/event_card_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:flutter/material.dart';

class ReportWidget extends StatefulWidget {
  @override
  _ReportWidgetState createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  final controller = ReportController();

  dynamic navigation = MainWidget();
  String title = "Eventos Denunciados";
  int screen = 6;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBarComponent(context, title: title),
      //, navigation: navigation),
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
                    future: controller.getReportedEvents(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Event> reportedEvents = snapshot.data;

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
                                  "Não há eventos Denunciados!",
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        controller.setListItems(snapshot.data);
                        return ListView.builder(
                            itemCount: controller.listItems.length,
                            itemBuilder: (_, index) {
                              var event = controller.listItems[index];
                              if (reportedEvents[index].active == true) {
                                return EventCard(
                                  eventName: reportedEvents[index].name,
                                  eventType: reportedEvents[index].type,
                                  eventAddress: reportedEvents[index].address,
                                  eventId: reportedEvents[index].id,
                                  eventConfirmed: reportedEvents[index].nbmrConfirmed,
                                  eventStars: null,
                                  eventDate: reportedEvents[index].dateString,
                                  eventImage: reportedEvents[index].image,
                                  onTapFunction: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RerportedEventWidget(
                                                  event: event),
                                        )).then((value) => setState(() {}));
                                  },
                                );

                            }else{
                              return Container();
                        }}
                            );
                        // ListView.builder(
                        //   itemCount: controller.listItems.length,
                        //   itemBuilder: (_, index) {
                        //     var event = controller.listItems[index];
                        //     return EventReportWidget(event: event);
                        //   });
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

//   Future<bool> checkToken() async {
//     _token = await _save.read(key: "token");
//     _userId = await _save.read(key: "userId");
//     if (_token == null) {
//       return false;
//     } else {
//       return true;
//     }
//   }
}

