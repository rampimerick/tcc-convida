import 'package:convida/app/screens/list_confirmed_users_screen/list_confirmed_controller.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';


// class ConfirmedListWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //Get event id
//     final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
//     final eventId = routeArgs['id'];

class ConfirmedListWidget extends StatefulWidget {
  final Event event;

  ConfirmedListWidget({Key key, @required this.event}) : super(key: key);

  @override
  State<ConfirmedListWidget> createState() => _ConfirmedListWidgetState(event);
}

class _ConfirmedListWidgetState extends State<ConfirmedListWidget> {
  Event event;

  _ConfirmedListWidgetState(this.event);

  @override
  Widget build(BuildContext context) {

    return Container(
        child: DraggableScrollableSheet(
            initialChildSize: 0.25,
            maxChildSize: 0.62,
            expand: true,
            builder: (context, scrollController) {
              return FutureBuilder(
                  future: getConfirmedUsers(context, event.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<User> allConfirmedUsers = snapshot.data;
                    if (snapshot.hasData) {
                      final total = allConfirmedUsers.length;
                      if (snapshot.hasData && total != 0) {
                        return Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(35.0),
                                topRight: const Radius.circular(35.0),
                              ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: getHeight(2)),
                                Text(
                                  "$total pessoa(s) confirmada(s)",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: allConfirmedUsers.length,
                                    itemBuilder: (context, index) {
                                      final user = allConfirmedUsers[index];
                                      return ConfirmedUsers(user);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(35.0),
                              topRight: const Radius.circular(35.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: getHeight(2)),
                                Text(
                                  "$total pessoa(s) confirmada(s)",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text("Ainda não há usuários confirmados no seu evento.",
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                        textAlign: TextAlign.center
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("",
                                  //"Usuários não disponíveis. Recarregue a página",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                      );
                    }
                  });
            }));
  }
}

class ConfirmedUsers extends StatelessWidget {

  final User _user;
  const ConfirmedUsers(this._user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: const Icon(Icons.people, color: Colors.deepOrange, size: 35),
        title: Text(_user.name + " " + _user.lastName),
        subtitle: Text(_user.email),
      ),
    );
  }
}



// class ListConfirmedUsersWidget extends StatefulWidget {
//   const ListConfirmedUsersWidget({Key key}) : super(key: key);
//
//   @override
//   State<ListConfirmedUsersWidget> createState() => _ListConfirmedUsersWidgetState();
// }
//
// class _ListConfirmedUsersWidgetState extends State<ListConfirmedUsersWidget> {
//   @override
//   Widget build(BuildContext context) {
//
//     // final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
//     // final eventId = routeArgs['id'];
//
//     return Scaffold(
//       //appBar:  AppBarComponent(context),
//       body: FutureBuilder(
//         future: getConfirmedUsers(context),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//           List<User> allConfirmedUsers = snapshot.data;
//           if (snapshot.connectionState != ConnectionState.done) {
//            return Progress();
//           }
//           else if(snapshot.hasData){
//             final total = allConfirmedUsers.length;
//             if (snapshot.connectionState != ConnectionState.done) {
//               return Progress();
//             } else if (snapshot.hasData) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 1, right: 1),
//                 child: Column(children: <Widget>[
//                   SizedBox(height: getHeight(2)),
//                   SectionTitle(
//                    title: "$total pessoa(s) confirmada(s)",
//                     onTap: () => {},
//                     //onTapText: "Ver Todos",
//                   ),
//                   Expanded(
//                     child: Container(
//                       color: Colors.transparent,
//                       child: ListView.builder(
//                         itemCount: allConfirmedUsers.length,
//                         itemBuilder: (context, indice) {
//                           final user = allConfirmedUsers[indice];
//                           return ConfirmedUsers(user);
//                         },
//                       ),
//                     ),
//                   )
//                 ],
//                 ),
//               );
//             }
//             else {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 12, right: 12),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const <Widget>[
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           "Ainda não há usuários confirmados no seu eveneto",
//                           style: TextStyle(
//                               color: kPrimaryColor,
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ]
//                 ),
//               );
//             }
//           }else{
//             return Padding(
//               padding: const EdgeInsets.only(left: 12, right: 12),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Usuários não disponíveis. Recarregue a página",
//                         style: TextStyle(
//                             color: kPrimaryColor,
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ]
//               ),
//             );
//           }
//         }
//       ),
//     );
//   }
// }
//
// class ConfirmedUsers extends StatelessWidget {
//   final User _user;
//   const ConfirmedUsers(this._user);
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Card(
//         child: ListTile(
//           leading: const Icon(
//               Icons.people,
//               color: Colors.deepOrange,
//               size: 35
//           ),
//           title: Text(_user.name + " " + _user.lastName),
//           subtitle: Text(_user.email),
//         ),
//     );
//   }
// }




