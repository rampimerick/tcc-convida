import 'package:convida/app/shared/DAO/event_requisitions.dart';
import 'package:convida/app/shared/components/section_title_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/global/constants.dart';

import '../../shared/components/event_card_component.dart';

class EventsWidget extends StatefulWidget {
  final Map filters;

  EventsWidget({
    Key key,
    this.filters,
  }) : super(key: key);

  @override
  _EventsWidgetState createState() => _EventsWidgetState(filters);
}

class _EventsWidgetState extends State<EventsWidget> {
  Map filters;

  _EventsWidgetState(this.filters);

  var jsonData;
  DateFormat date = new DateFormat.yMMMMd("pt_BR");
  DateFormat hour = new DateFormat.Hm();

  String search = "";
  String type = "";
  bool checked = false;

  Color healthColor = Colors.white;
  Color sportColor = Colors.white;
  Color partyColor = Colors.white;
  Color artColor = Colors.white;
  Color faithColor = Colors.white;
  Color studyColor = Colors.white;
  Color othersColor = Colors.white;

  Color healthLine = kHealthColor;
  Color sportLine = kSportColor;
  Color partyLine = kPartyColor;
  Color artLine = kArtColor;
  Color faithLine = kFaithColor;
  Color studyLine = kGraduationColor;
  Color othersLine = kOtherColor;
  int screen = 7;

  final TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            //initialData: "Loading..",
            future: getEventsSearchType(search, filters, context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Event> events = snapshot.data;
              return Column(
                children: <Widget>[
                  SizedBox(height: getHeight(2)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: getMediumPadding(),
                              vertical: getSmallPadding()),
                          child: TextFormField(
                              maxLines: 1,
                              controller: _searchController,
                              onChanged: (value) {
                                setState(
                                  () {
                                    search = value;
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11.0, horizontal: 20.0),
                                hintText: "Digite aqui",
                                prefixIcon: Icon(Icons.search, size: 26),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30.0)),
                                filled: true,
                                fillColor: Colors.grey[200],
                              )),
                        ),
                      ),
                    ],
                  ),
                  SectionTitle(
                    title: "Resultados",
                    onTap: () {
                      setState(
                        () {
                          search = "";
                        },
                      );
                    },
                    onTapText: "Ver Todos",
                  ),
                  Expanded(
                      child: Observer(builder: (context) {
                        if (snapshot.data == null) {
                        return ShimmerComponent(screen: screen);
                        } else {
                        return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (BuildContext context, int index) {
                             return EventCard(
                                eventDate: events[index].dateString,
                                eventName: events[index].name,
                                eventType: events[index].type,
                                eventImage: events[index].typeImage,
                                eventStars: events[index].nbmrFavorites,
                                eventAddress: events[index].address,
                                eventId: events[index].id,
                                eventConfirmed: events[index].nbmrConfirmed,
                                onTapFunction: () {
                                  Navigator.pushNamed(context, '/event',
                                          arguments: {'id': events[index].id})
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                              );
                            }
                        );
                        }})
                        )
                ],
              );
            }));
  }
}
