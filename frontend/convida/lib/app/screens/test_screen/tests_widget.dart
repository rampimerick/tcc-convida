import 'package:convida/app/shared/DAO/event_requisitions.dart';
import 'package:convida/app/shared/components/section_title_component.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:flutter/material.dart';
import 'package:convida/app/shared/global/constants.dart';

class TestsWidget extends StatefulWidget {
  @override
  _TestsWidgetState createState() => _TestsWidgetState();
}

class _TestsWidgetState extends State<TestsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          SectionTitle(
            title: "Próximos",
            onTap: () {},
            onTapText: "Ver Todos",
          ),
          FutureBuilder(
            future: getEvents("", "", false, context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Event> events = snapshot.data;
              if (events == null)
                return SizedBox(
                    height: getHeight(40),
                    child: CircularLoading(padding: 24.0));
              else if (events.length > 0)
                return Container(
                  child: SizedBox(
                    height: getHeight(40),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: getWidth(38),
                            child: Padding(
                                padding: EdgeInsets.all(getSmallPadding()),
                                child: LayoutBuilder(builder: (_, constraints) {
                                  return EventCard(
                                    eventDate: events[index].dateString,
                                    eventName: events[index].name,
                                    eventIcon: events[index].typeIcon,
                                    eventIconColor: events[index].typeColor,
                                    eventImage: events[index].typeImage,
                                    eventStars: events[index].nbmrFavorites,
                                    cardSize: Size(constraints.maxWidth,
                                        constraints.maxHeight),
                                    onTapFunction: () {
                                      Navigator.pushNamed(context, '/event',
                                          arguments: {
                                            'id': events[index].id
                                          }).then((value) {
                                        setState(() {});
                                      });
                                    },
                                  );
                                })),
                          );
                        }),
                  ),
                );
              else
                return CircularLoading(padding: 64.0);
            },
          ),
          SectionTitle(
            title: "Populares",
            onTap: () {},
            onTapText: "Ver Todos",
          ),
          FutureBuilder(
            future: getEventsByPresence(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Event> events = snapshot.data;
              if (events == null)
                return CircularLoading(padding: 64.0);
              else if (events.length > 0)
                return Container(
                  child: SizedBox(
                    height: getHeight(40),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: getWidth(38),
                            child: Padding(
                                padding: EdgeInsets.all(getSmallPadding()),
                                child: LayoutBuilder(builder: (_, constraints) {
                                  return EventCard(
                                    eventDate: events[index].dateString,
                                    eventName: events[index].name,
                                    eventIcon: events[index].typeIcon,
                                    eventIconColor: events[index].typeColor,
                                    eventImage: events[index].typeImage,
                                    eventStars: events[index].nbmrFavorites,
                                    cardSize: Size(constraints.maxWidth,
                                        constraints.maxHeight),
                                    onTapFunction: () {
                                      Navigator.pushNamed(context, '/event',
                                          arguments: {
                                            'id': events[index].id
                                          }).then((value) {
                                        setState(() {});
                                      });
                                    },
                                  );
                                })),
                          );
                        }),
                  ),
                );
              else
                return CircularLoading(padding: 64.0);
            },
          ),
        ],
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  const CircularLoading({Key key, @required this.padding}) : super(key: key);

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard(
      {Key key,
      @required this.eventIcon,
      @required this.eventIconColor,
      @required this.eventImage,
      @required this.eventName,
      @required this.eventDate,
      @required this.eventStars,
      @required this.onTapFunction,
      @required this.cardSize})
      : super(key: key);

  final Size cardSize;
  final String eventIcon;
  final Color eventIconColor;
  final String eventImage;
  final String eventName;
  final String eventDate;
  final int eventStars;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        child: Stack(
          children: [
            //Event Body:
            Column(
              children: [
                EventCardImage(eventImage: eventImage, cardSize: cardSize),
                EventCardDescription(
                    cardSize: cardSize,
                    eventName: eventName,
                    eventDate: eventDate,
                    eventStars: eventStars),
              ],
            ),
            //Event Icon on the upper-left corner:
            EventCardIcon(
              cardSize: cardSize,
              eventIcon: eventIcon,
              eventIconColor: eventIconColor,
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardDescription extends StatelessWidget {
  const EventCardDescription(
      {Key key,
      @required this.cardSize,
      @required this.eventName,
      @required this.eventDate,
      @required this.eventStars})
      : super(key: key);

  final Size cardSize;
  final String eventName;
  final String eventDate;
  final int eventStars;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardSize.width,
      padding: EdgeInsets.only(
          left: getSmallPadding() + 1,
          right: getSmallPadding() + 1,
          bottom: getSmallPadding() + 2),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    eventName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 10, color: kPrimaryColor),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  eventDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 8, color: Colors.grey.shade700),
                ),
              ),
              Icon(Icons.star, size: 8, color: Colors.grey.shade700),
              //If Event > 9999
              Text(
                eventStars.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 8, color: Colors.grey.shade700),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class EventCardImage extends StatelessWidget {
  const EventCardImage({
    Key key,
    @required this.eventImage,
    @required this.cardSize,
  }) : super(key: key);

  final String eventImage;
  final Size cardSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.grey.shade100,
        ),
        child: Padding(
          padding: EdgeInsets.all(getSmallPadding()),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(eventImage,
                width: cardSize.width, fit: BoxFit.fitWidth),
          ),
        ));
  }
}

class EventCardIcon extends StatelessWidget {
  const EventCardIcon(
      {Key key,
      @required this.eventIcon,
      @required this.eventIconColor,
      @required this.cardSize})
      : super(key: key);

  final Size cardSize;
  final String eventIcon;
  final Color eventIconColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: cardSize.width / 5,
        height: cardSize.width / 5,
        color: eventIconColor,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Image.asset(eventIcon,
              color: Colors.white,
              height: SizeConfig.safeBlockVertical * 0.2,
              width: SizeConfig.safeBlockHorizontal * 0.2,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
