
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:convida/app/shared/helpers/style_helper.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {Key key,
      @required this.eventName,
      @required this.eventType,
      @required this.eventConfirmed,
      @required this.onTapFunction,
      @required this.eventAddress,
      @required this.eventId,
      @required this.eventDate,
      @required this.eventStars,
        @required this.eventImage})
      : super(key: key);

  final String eventName;
  final String eventType;
  final int eventConfirmed;
  final String eventAddress;
  final String eventId;
  final Function onTapFunction;
  final String eventDate;
  final int eventStars;
  final String eventImage;

  @override
  Widget build(BuildContext context) {

    String _imageAsset;

    if(eventImage == null) {
      if (eventType == 'Saúde e Bem-estar') {
        _imageAsset = 'assets/images/1.jpg';
      } else if (eventType == 'Esporte e Lazer') {
        _imageAsset = 'assets/images/2.jpg';
      } else if (eventType == 'Festas e Comemorações') {
        _imageAsset = 'assets/images/3.jpg';
      } else if (eventType == 'Online') {
        _imageAsset = 'assets/images/7.jpg';
      } else if (eventType == 'Arte e Cultura') {
        _imageAsset = 'assets/images/4.jpg';
      } else if (eventType == 'Fé e Espiritualidade') {
        _imageAsset = 'assets/images/5.jpg';
      } else if (eventType == 'Acadêmico e Profissional') {
        _imageAsset = 'assets/images/6.jpg';
      } else {
        _imageAsset = 'assets/images/7.jpg';
      }
    }else{
      _imageAsset = eventImage;
    }
//Ver com o Erick para criar um endpoint para trazer somente eventos com ao menos uma denúncia não ignorada

    return Container(
        height: getHeight(16),
        child: Padding(
            padding: EdgeInsets.fromLTRB(getMediumPadding(), getSmallPadding(),
                getMediumPadding(), getSmallPadding()),
            child: InkWell(
              onTap: onTapFunction,
              child: LayoutBuilder(builder: (_, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(getSmallPadding()),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(_imageAsset,
                                height: constraints.maxHeight,
                                fit: BoxFit.fitHeight),
                          ),
                        )),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: constraints.maxHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(getMediumPadding()),
                            child: Column(
                              children: [
                                //Title
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        eventName,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16, color: kPrimaryColor),
                                      ),
                                    )
                                  ],
                                ),
                                //Date
                                eventDate == null
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: TextDescription(
                                                text: eventAddress,
                                              softWrap: true
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child:
                                                TextDescription(text: eventDate),
                                          )
                                        ],
                                      ),

                                Spacer(),

                                eventStars == null
                                    ? Row(
                                        children: [
                                          Icon(Icons.library_add_check,
                                              size: 10,
                                              color: Colors.grey.shade700),
                                          //If Event > 9999
                                          Expanded(
                                            child: TextDescription(
                                                text: eventConfirmed.toString()),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Icon(Icons.star_border_outlined,
                                              size: 10,
                                              color: Colors.grey.shade700),
                                          //If Event > 9999
                                          Expanded(
                                            child: TextDescription(
                                                text: eventStars.toString()),
                                          ),
                                        ],
                                      ),

                                Row(children: [
                                  Expanded(
                                    child: TextDescription(
                                      text: eventType,
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
            )));
  }
}
