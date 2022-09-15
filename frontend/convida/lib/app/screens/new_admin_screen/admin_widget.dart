import 'package:convida/app/screens/list_admins_screen/list_widget.dart';
import 'package:convida/app/screens/new_admin_screen/admin_controller.dart';
import 'package:convida/app/shared/components/appbar_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:convida/app/shared/components/section_title_component.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AdminWidget extends StatefulWidget {
  AdminWidget({Key key}) : super(key: key);

  @override
  _AdminWidgetState createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  String search = "";
  String pressed = "";
  String token;
  String title = "Novo Administrador";
  int screen = 4;
  IconData person = Icons.person;
  IconData add = Icons.add;

  dynamic navigation = ListAdminWidget();

  final TextEditingController _searchController = new TextEditingController();

  final NewAdminController _newAdminController = new NewAdminController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(context, title: title, navigation: navigation),
        body: Container(
          child: FutureBuilder(
              future: _newAdminController.getUsersNameSearch(search, context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Column(children: <Widget>[
                  SizedBox(height: getHeight(2)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getMediumPadding(),
                              vertical: getSmallPadding()),
                          child: TextFormField(
                              maxLines: 1,
                              controller: _searchController,
                              onChanged: (value) {
                                _newAdminController.getUsersNameSearch(
                                    value, context);
                                // setState(
                                //       () {
                                search = value;
                                //   },
                                // );
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
                      search = "";
                    },
                    onTapText: "Ver Todos",
                  ),
                  Expanded(
                    child: Observer(builder: (context) {
                      if (snapshot.data == null ||
                          snapshot.connectionState != ConnectionState.done) {
                        return ShimmerComponent(
                            screen: screen, icon: person, iconOperation: add);
                      } else {
                        return ListView.builder(
                          itemCount: _newAdminController.listItems.length,
                          itemBuilder: (context, index) {
                            if (_newAdminController.listItems[index].name !=
                                    null &&
                                _newAdminController.listItems[index].lastName !=
                                    null &&
                                _newAdminController.listItems[index].adm !=
                                    true) {
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.person,
                                      color: Colors.blueAccent, size: 50),
                                  title: Text(_newAdminController
                                          .listItems[index].name +
                                      " " +
                                      _newAdminController
                                          .listItems[index].lastName),
                                  subtitle: Text(_newAdminController
                                      .listItems[index].email),
                                  trailing: IconButton(
                                    onPressed: () => {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Atenção'),
                                          content: const Text(
                                              'Você realmente deseja adicionar este usuário como administrador?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Cancelar'),
                                            ),
                                            Observer(builder: (_) {
                                              return TextButton(
                                                onPressed: () => {
                                                  _newAdminController.putAdmin(
                                                      context,
                                                      _newAdminController
                                                          .listItems[index].id),
                                                  setState(
                                                    () {
                                                      pressed =
                                                          _newAdminController
                                                              .listItems[index]
                                                              .id;
                                                    },
                                                  ),
                                                },
                                                child: const Text('Ok'),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    },
                                    icon: Icon(Icons.add, size: 36),
                                    color: const Color(0xFF255D83),
                                  ),
                                ),
                              );
                            } else {
                              return Column();
                            }
                            // AdminCard(
                            // name: users[index].name,
                            // lastName: users[index].lastName,
                            // isAdmin: users[index].adm,
                            // email: users[index].email,
                            // id: users[index].id,
                            // onTapFunction: (value) {
                            //     setState(
                            //           () {
                            //         pressed = true;
                            //       },
                            //     );
                            //     },
                            // );
                          },
                        );
                      }
                    }),
                  ),
                ]);

                // } else {
                //   return Padding(
                //     padding: const EdgeInsets.only(left: 12, right: 12),
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: const <Widget>[
                //           Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: Text(
                //               "Usuários não disponíveis. Recarregue a página",
                //               style: TextStyle(
                //                   color: kPrimaryColor,
                //                   fontSize: 28,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ]),
                //   );
                //),
              }),
        ));
  }
}
