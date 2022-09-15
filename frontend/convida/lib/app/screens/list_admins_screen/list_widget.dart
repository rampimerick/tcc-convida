import 'package:convida/app/screens/list_admins_screen/list_controller.dart';
import 'package:convida/app/screens/main_screen/main_widget.dart';
import 'package:convida/app/screens/new_admin_screen/admin_widget.dart';
import 'package:convida/app/shared/components/appbar_component.dart';
import 'package:convida/app/shared/components/shimmer_component.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class ListAdminWidget extends StatefulWidget {
  const ListAdminWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<ListAdminWidget> createState() => _ListAdminWidgetState();
}

class _ListAdminWidgetState extends State<ListAdminWidget> {

  final _newAdminController = ListAdminController();
  dynamic navigation = MainWidget();
  int screen = 5;
  IconData person = Icons.person;
  IconData add = Icons.delete_forever;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context, navigation: navigation),
      body: FutureBuilder(
          future: _newAdminController.getAllAdmins(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ShimmerComponent(screen: screen, icon: person, iconOperation: add);
            }else if (snapshot.hasData){
              return Observer(
                  builder: (_) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _newAdminController.listItems.length,
                            itemBuilder: (context, index) {
                              final user = _newAdminController.listItems[index];
                              return Card(
                                child: ListTile(
                                  leading: const Icon(
                                      Icons.person,
                                      color: kSecondaryColor,
                                      size: 50
                                  ),
                                  title: Text(user.name + " " + user.lastName),
                                  subtitle: Text(user.email),
                                  trailing: IconButton(
                                      onPressed: () =>
                                      {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text('Atenção'),
                                                content: const Text(
                                                    'Você realmente deseja remover este administrador?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context).pop(),
                                                    child: const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                    {
                                                      _newAdminController
                                                          .removeAdmin(
                                                          context, user.id),
                                                      //setState(() {}),
                                                      //Navigator.of(context).pop(),
                                                    },
                                                    child: const Text('Ok'),
                                                  ),
                                                ],
                                              ),
                                        ),
                                      },
                                      icon: const Icon(
                                          Icons.delete_forever, size: 36),
                                      color: kPrimaryColor
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
              }
              );
            }
            else{
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Administradores não disponíveis. Recarregue a página",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]
                ),
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
          //mini: true,
          child: Icon(Icons.add, size: 32),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Navigator.of(context)
                .push(
                MaterialPageRoute(
                    builder: (context) =>  AdminWidget()
                )
            ).then((value) => setState(() {}));
          }
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(height: 60),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}