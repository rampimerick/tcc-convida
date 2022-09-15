import 'package:convida/app/screens/reported_event_screen/reported_event_controller.dart';
import 'package:convida/app/shared/components/appbar_component.dart';
import 'package:convida/app/shared/components/progress_component.dart';
import 'package:convida/app/shared/helpers/style_helper.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RerportedEventWidget extends StatefulWidget {
  final Event event;

  RerportedEventWidget({Key key, @required this.event}) : super(key: key);

  @override
  _RerportedEventWidgetState createState() => _RerportedEventWidgetState(event);
}

//! CLASSE COM NOME ERRADO !
class _RerportedEventWidgetState extends State<RerportedEventWidget> {
  Event event;

  _RerportedEventWidgetState(this.event);

  final controller = ReportedEventController();

  String title = "Denúncias";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBarComponent(context, title: title),
        body: FutureBuilder(
            future: controller.updateList(event.id, context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null ||
                  snapshot.connectionState != ConnectionState.done) {
                return Progress();
              } else {
                return Column(
                  children: <Widget>[
                    Observer(builder: (_) {
                      if (controller.listReports.length == 0) {
                        return Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      "Todas as denúncias foram verificadas!",
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          flex: 10,
                          child: ListView.builder(
                              itemCount: controller.listReports.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Observer(builder: (_) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            //height: 170,
                                            child: Card(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.announcement_outlined , size: 35, color: Colors.deepPurple),
                                                title: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextTitle(
                                                        text:
                                                            "Reportado por: ${controller.listReports[index].author}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10.0,
                                                                bottom: 15),
                                                        child: Text(
                                                          controller
                                                              .listReports[
                                                                  index]
                                                              .description,
                                                          maxLines: 8,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                trailing: InkWell(
                                                  onTap: () => showConfirm(
                                                      title: "Remover denúncia",
                                                      content:
                                                          "Deseja realmente remover esta denúncia?",
                                                      onPressed: () {
                                                        controller.removeReport(
                                                            controller
                                                                    .listReports[
                                                                index],
                                                            context);
                                                        Navigator.pop(context);
                                                      },
                                                      context: context),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: (
                                                              IconButton(
                                                            icon: const Icon(
                                                                Icons.delete_forever,
                                                                size: 30,
                                                                color:
                                                                    kSecondaryColor), onPressed: () {  },
                                                          )),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 1.0,
                                                                  top: 8.0,
                                                                  right: 1.0),
                                                          child: Text(
                                                            "Ignorar",
                                                            style: TextStyle(
                                                              color:
                                                                  kSecondaryColor,
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  );
                                });
                              }),
                        );
                      }
                    }),
                    Expanded(
                      flex: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? 1
                          : 2,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // Expanded(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(2.0),
                              //     child: InkWell(
                              //       onTap: () {
                              //         Navigator.of(context).pop();
                              //       },
                              //       child: Column(
                              //         children: <Widget>[
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.only(top: 0.0),
                              //             child: Icon(
                              //               Icons.report_off,
                              //               size: 26,
                              //               color: Color(primaryColor),
                              //             ),
                              //           ),
                              //           Text("Ignorar Denúncias")
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              event.active == true
                                  //Deactivate Event
                                  ? Observer(builder: (_) {
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: InkWell(
                                            onTap: controller.loading
                                                ? null
                                                : () async {
                                                    bool success;
                                                    showConfirm(
                                                        title:
                                                            "Desativar Evento",
                                                        content:
                                                            "Deseja realmente desativar este evento?",
                                                        onPressed: () async {
                                                          success =
                                                              await controller
                                                                  .getDeactivate(
                                                                      event.id,
                                                                      context);
                                                          Navigator.pop(
                                                              context);

                                                          if (success) {
                                                            showSuccess(
                                                                "Evento Desativado",
                                                                "pop",
                                                                context);
                                                          }
                                                        },
                                                        context: context);
                                                  },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(Icons.cancel,
                                                    size: 26,
                                                    color: Colors.red),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0),
                                                  child:
                                                      Text("Desativar Evento"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })

                                  //Ativate Event
                                  : Observer(builder: (_) {
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: InkWell(
                                            onTap: controller.loading
                                                ? null
                                                : () async {
                                                    bool success;
                                                    showConfirm(
                                                        title: "Ativar Evento",
                                                        content:
                                                            "Deseja realmente Ativar este evento?",
                                                        onPressed: () async {
                                                          success =
                                                              await controller
                                                                  .getActivate(
                                                                      event.id,
                                                                      context);
                                                          Navigator.pop(
                                                              context);

                                                          if (success) {
                                                            showSuccess(
                                                                "Evento Ativado",
                                                                "pop",
                                                                context);
                                                          }
                                                        },
                                                        context: context);
                                                  },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(Icons.check_circle,
                                                    size: 26,
                                                    color: Colors.green),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0),
                                                  child: Text("Ativar Evento"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                            ]),
                      ),
                    )
                  ],
                );
              }
            }),
      ),
      onWillPop: null,
    );
  }
}
