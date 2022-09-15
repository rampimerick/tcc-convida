import 'package:flutter/material.dart';

class _EventDescription extends StatelessWidget {
  _EventDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.eventDate,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String eventDate;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$author',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$eventDate',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.eventDate,
    
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String eventDate;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,20,2,20),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: thumbnail,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _EventDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  eventDate: eventDate,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//                        //return 
//                          SizedBox(
//                               width: double.infinity,
//                               height: 120,
//                               child: Card(
//                                 child: Column(
//                                   children: <Widget>[
//                                     //Event's Info:
//                                     ListTile(
//                                       title: Text(
//                                         values[index].name,
//                                         style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 21.0,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                       subtitle: Text(
//                                         "${date.format(eventDate)} - ${hour.format(eventHour)}",
//                                         style: TextStyle(
//                                             fontStyle: FontStyle.italic,
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.w300),
//                                       ),
//                                       leading: CircleAvatar(
//                                         radius: 42.0,
//                                         backgroundColor: Colors.white,
//                                         child:
//                                             Image.asset("assets/$_imageAsset"),
//                                       ),
//                                       isThreeLine: true,

                                      
//                                       trailing: PopupMenuButton<WhyFarther>(
//                                         onSelected: (WhyFarther result) {
//                                           setState(() {});
//                                         },
//                                         itemBuilder: (BuildContext context) =>
//                                             <PopupMenuEntry<WhyFarther>>[
//                                           const PopupMenuItem<WhyFarther>(
//                                             value: WhyFarther.Alterar,
//                                             child: Text('Alterar evento'),
//                                           ),
//                                           const PopupMenuItem<WhyFarther>(
//                                             value: WhyFarther.Deletar,
//                                             child: Text('Deletar evento'),
//                                           ),
//                                         ],
//                                       ),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, '/my-detailed-event',
//                                             arguments: {
//                                               'id': values[index].id
//                                             });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );