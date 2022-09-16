import 'dart:convert';
import 'dart:io';
import 'package:convida/app/screens/deactivated_events_screen/deactivated_events_widget.dart';
import 'package:convida/app/screens/list_admins_screen/list_widget.dart';
import 'package:convida/app/screens/organization_screen/organization_widget.dart';
import 'package:convida/app/screens/report_screen/report_widget.dart';
import 'package:convida/app/screens/test_screen/tests_widget.dart';
import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/components/tabs_component.dart';
import 'package:convida/app/shared/global/size_config.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:convida/app/screens/alter_profile_screen/alter_profile_widget.dart';
import 'package:convida/app/screens/events_screen/events_widget.dart';
import 'package:convida/app/screens/map_screen/map_widget.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/models/user.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final _save = FlutterSecureStorage();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  // void _closeEndDrawer() {
  //   Navigator.of(context).pop();
  // }
  //
  // void _click() {
  //   Navigator.of(context).pop();
  // }

  int currentIndex = 0;

  Map<String, bool> filtersMap = {
    'healthType': false,
    'sportType': false,
    'partyType': false,
    'artType': false,
    'faithType': false,
    'studyType': false,
    'othersType': false,
    'dataTypeAll': false,
    'dataTypeWeek': false,
    'dataTypeDay': false,
  };

  //Criar um util Filters:
  void _setFalseAllFilters(filtersMap) {
    filtersMap['healthType'] = false;
    filtersMap['sportType'] = false;
    filtersMap['partyType'] = false;
    filtersMap['artType'] = false;
    filtersMap['faithType'] = false;
    filtersMap['othersType'] = false;
    filtersMap['dataTypeWeek'] = false;
    filtersMap['dataTypeDay'] = false;
  }

  void _switchFilterTypeOf(String type) {
    if (filtersMap[type]) {
      filtersMap[type] = false;
    } else {
      filtersMap[type] = true;
    }

  }

  Color healthColor = Colors.white;
  Color sportColor = Colors.white;
  Color partyColor = Colors.white;
  Color artColor = Colors.white;
  Color faithColor = Colors.white;
  Color studyColor = Colors.white;
  Color othersColor = Colors.white;

  Color dayColor = Colors.white;
  Color weekColor = Colors.white;
  Color monthColor = Colors.white;

  bool admin;

  User user;
  String _url = kURL;

  String _name;
  String _lastName;
  String _email;
  String _token;
  String _avatar;

  bool switchScreen = false;

  FloatingActionButton getDrawer() {
    return FloatingActionButton(
      heroTag: 0,
      backgroundColor: kPrimaryColor,
      mini: true,
      onPressed: () async {
        _scaffoldKey.currentState.openDrawer();

        final save = FlutterSecureStorage();
        final t = await save.read(key: "token");

        if (t != null) {
          String success = await getUserProfile();
        }
      },
      child: Icon(Icons.format_list_bulleted),
    );
  }

  void _showDialog(String s, String desc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(s),
          content: Text(desc),
          actions: <Widget>[
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.pop(context);
                exit(0);
              },
            ),
            TextButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double sizeAppBarIcon = 28;
    //double sizeAppBarTitle = 12;
    return WillPopScope(
      //Ends the app
      onWillPop: () {
        if (currentIndex == 0) {
          _showDialog("Saindo", "Deseja realmente sair do UFPR ConVIDA?");
          return null;
        } else {
          setState(() {
            _setFalseAllFilters(filtersMap);
          });
          return null;
        }
      },

      child: FutureBuilder(
          future: checkToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return FutureBuilder(
              future: getUserProfile(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.data != null) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    key: _scaffoldKey,
                    drawer: _token == null
                    //Drawer without user:
                        ? drawerNoUser()
                    //Drawer of the user:
                        : drawerUser(context),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: kPrimaryColor),
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      leading: Builder(builder: (BuildContext context) {
                        return
                          IconButton(
                            icon: ImageIcon(
                              AssetImage('assets/icons/menu.png'),
                              color: Color.fromRGBO(255, 73, 51, 1),
                              size: 32,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          );
                      }),
                      title:
                      Image.asset("assets/logos/logo-ufprconvida.png", scale: 16),
                      actions: getActions(currentIndex, context),

                    ),
                    endDrawer: getEndDrawer(currentIndex),
                    body: MyScaffoldBody(
                      index: currentIndex,
                      filters: filtersMap,
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      currentIndex: currentIndex,
                      type: BottomNavigationBarType.fixed,
                      onTap: (value) {
                        switchScreen = true;
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: ImageIcon(AssetImage("assets/icons/events.png"),
                                color: currentIndex == 0
                                    ? kPrimaryColor
                                    : Colors.grey[500],
                                size: sizeAppBarIcon),
                            label: ("Eventos")
                          // title: Text("Eventos",
                          //     style: TextStyle(fontSize: sizeAppBarTitle))
                        ),
                        BottomNavigationBarItem(
                            icon: ImageIcon(AssetImage("assets/icons/map.png"),
                                color: currentIndex == 1
                                    ? kPrimaryColor
                                    : Colors.grey[500],
                                size: sizeAppBarIcon),
                            label: ("Mapa")
                          // title: Text("Mapa",
                          //     style: TextStyle(fontSize: sizeAppBarTitle))
                        ),
                        // BottomNavigationBarItem(
                        //     icon: ImageIcon(AssetImage(
                        //         "assets/icons/favourite.png"),
                        //         color: currentIndex == 2
                        //             ? kPrimaryColor
                        //             : Colors.grey[500],
                        //         size: sizeAppBarIcon),
                        //     label: ("Favoritos")
                        //   //style: TextStyle(fontSize: sizeAppBarTitle))
                        // ),
                        // BottomNavigationBarItem(
                        //     icon: ImageIcon(AssetImage("assets/icons/others.png"),
                        //         color: currentIndex == 3
                        //             ? kPrimaryColor
                        //             : Colors.grey[500],
                        //         size: sizeAppBarIcon),
                        //     label: ("Meus Eventos")
                        //   // title: Text("Meus Eventos",
                        //   //     style: TextStyle(fontSize: sizeAppBarTitle))
                        // ),
                        BottomNavigationBarItem(
                            icon: ImageIcon(AssetImage("assets/icons/search.png"),
                                color: currentIndex == 2
                                    ? kPrimaryColor
                                    : Colors.grey[500],
                                size: sizeAppBarIcon),
                            label: ("Pesquisar")
                          // title: Text(
                          //   "Pesquisar",
                          //   style: TextStyle(fontSize: sizeAppBarTitle),
                          // )
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.my_library_add_outlined,
                                color: currentIndex == 3
                                    ? kPrimaryColor
                                    : Colors.grey[500],
                                size: sizeAppBarIcon),
                            label: ("Meus eventos")
                          // title: Text(
                          //   "Pesquisar",
                          //   style: TextStyle(fontSize: sizeAppBarTitle),
                          // )
                        ),
                      ],
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
      ),
    );
  }

  Drawer endDrawer() {
    if (filtersMap['healthType'])
      healthColor = Color.fromRGBO(249, 143, 155, 1);
    if (filtersMap['sportType']) sportColor = Color.fromRGBO(148, 197, 151, 1);
    if (filtersMap['partyType']) partyColor = Color.fromRGBO(152, 137, 206, 1);
    if (filtersMap['artType']) artColor = Color.fromRGBO(234, 108, 160, 1);
    if (filtersMap['faithType']) faithColor = Color.fromRGBO(234, 196, 38, 1);
    if (filtersMap['studyType']) studyColor = Color.fromRGBO(108, 159, 221, 1);
    if (filtersMap['othersType'])
      othersColor = Color.fromRGBO(186, 186, 186, 1);
    if (filtersMap['dataTypeWeek']) weekColor = Color(0xFF4c84cd);
    if (filtersMap['dataTypeDay']) dayColor = Color(0xFF4c84cd);

    return Drawer(
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              child: Text(
                "Tipo de eventos:",
                style: TextStyle(
                    color: kPrimaryColor, //Color(secondaryColor),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8.0,
              children: <Widget>[
                CustomFilterButton(
                  text: 'Saúde e Bem-estar',
                  image: kHealthIcon,
                  color: healthColor,
                  standardColor: Color.fromRGBO(249, 143, 155, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['healthType']) {
                        _switchFilterTypeOf('healthType');
                        healthColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('healthType');
                        healthColor = Color.fromRGBO(249, 143, 155, 1);
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Esporte e Lazer',
                  image: kSportIcon,
                  color: sportColor,
                  standardColor: Color.fromRGBO(148, 197, 151, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['sportType']) {
                        _switchFilterTypeOf('sportType');
                        sportColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('sportType');
                        sportColor = Color.fromRGBO(148, 197, 151, 1);
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Festas e Comemorações',
                  image: kPartyIcon,
                  color: partyColor,
                  standardColor: Color.fromRGBO(152, 137, 206, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['partyType']) {
                        _switchFilterTypeOf('partyType');
                        partyColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('partyType');
                        partyColor = Color.fromRGBO(152, 137, 206, 1);
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Arte e Cultura',
                  image: kArtIcon,
                  color: artColor,
                  standardColor: Color.fromRGBO(234, 108, 160, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['artType']) {
                        _switchFilterTypeOf('artType');
                        artColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('artType');
                        artColor = Color.fromRGBO(234, 108, 160, 1);
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Fé e Espiritualidade',
                  image: kFaithIcon,
                  color: faithColor,
                  standardColor: Color.fromRGBO(234, 196, 38, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['faithType']) {
                        _switchFilterTypeOf('faithType');
                        faithColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('faithType');
                        faithColor = Color.fromRGBO(234, 196, 38, 1);
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Acadêmico e Profissional',
                  image: kGraduationIcon,
                  color: studyColor,
                  standardColor: Color.fromRGBO(108, 159, 221, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['studyType']) {
                        _switchFilterTypeOf('studyType');
                        studyColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('studyType');
                        studyColor = Color.fromRGBO(108, 159, 221, 1);
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Outros',
                  image: kOtherIcon,
                  color: othersColor,
                  standardColor: Color.fromRGBO(186, 186, 186, 1),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['othersType']) {
                        _switchFilterTypeOf('othersType');
                        othersColor = Colors.white;
                      } else {
                        _switchFilterTypeOf('othersType');
                        othersColor = Color.fromRGBO(186, 186, 186, 1);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              child: Text(
                "Datas dos eventos:",
                style: TextStyle(
                    color: kPrimaryColor, //Color(secondaryColor),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Wrap(
              children: <Widget>[
                CustomFilterButton(
                  text: 'Eventos acontecendo hoje',
                  image: kEventIcon,
                  color: dayColor,
                  standardColor: Color(0xFF4c84cd),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['dataTypeWeek']) {
                        filtersMap['dataTypeWeek'] = false;
                        filtersMap['dataTypeDay'] = true;
                        weekColor = Colors.white;
                        dayColor = Color(0xFF4c84cd);
                      } else if (!filtersMap['dataTypeDay']) {
                        filtersMap['dataTypeDay'] = true;
                        dayColor = Color(0xFF4c84cd);
                      } else {
                        filtersMap['dataTypeDay'] = false;
                        dayColor = Colors.white;
                      }
                    });
                  },
                ),
                CustomFilterButton(
                  text: 'Eventos nos próximos 7 dias',
                  image: kEventIcon,
                  color: weekColor,
                  standardColor: Color(0xFF4c84cd),
                  onPressed: () {
                    setState(() {
                      if (filtersMap['dataTypeDay']) {
                        filtersMap['dataTypeDay'] = false;
                        filtersMap['dataTypeWeek'] = true;
                        dayColor = Colors.white;
                        weekColor = Color(0xFF4c84cd);
                      } else if (!filtersMap['dataTypeWeek']) {
                        filtersMap['dataTypeWeek'] = true;
                        weekColor = Color(0xFF4c84cd);
                      } else {
                        filtersMap['dataTypeWeek'] = false;
                        weekColor = Colors.white;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawerNoUser() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("UFPR ConVIDA"),
            accountEmail: Text("Favor fazer Login!"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("UFPR"),
            ),
          ),
          drawerLogin(),
          //drawerSignup(),
          Divider(),
          drawerAbout(),
          ListTile(
            title: Text("Fechar menu"),
            trailing: Icon(Icons.close),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: Text("Sair do app"),
              trailing: Icon(Icons.close),
              onTap: () {
                _showDialog("Saindo", "Deseja realmente sair do UFPR ConVIDA?");
              })
        ],
      ),
    );
  }

  // ListTile drawerReport() {
  //   return ListTile(
  //       title: Text("Denúncias"),
  //       trailing: Icon(Icons.assignment_late),
  //       onTap: () {
  //         //Pop Drawer:
  //         Navigator.of(context).pop();
  //         //Push Login Screen:
  //         Navigator.of(context).pushNamed("/report");
  //       });
  // }

  ListTile drawerAbout() {
    return ListTile(
        title: Text("Sobre"),
        trailing: Icon(Icons.info),
        onTap: () {
          //Pop Drawer:
          Navigator.of(context).pop();
          //Push Login Screen:
          Navigator.of(context).pushNamed("/about");
          //Navigator.of(context).pushReplacementNamed("/about");
        });
  }

  Drawer drawerUser(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("$_name $_lastName"),
            accountEmail: Text("$_email"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("$_avatar"),
            ),
          ),

          ListTile(
            title: Text("Perfil"),
            trailing: Icon(Icons.person),
            onTap: () async {
              if (_token != null) {
                String success = await getUserProfile();
              }
              //Pop Drawer:
              Navigator.of(context).pop();

              //Push Alter Profile Screen
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlterProfileWidget(
                      user: user,
                    ),
                  ));
            },
          ),
          //new DrawerSettings(),
          new DrawerLogout(),
          new Divider(),
          //!Falta implementar algumas coisas

          // admin == true ? drawerReport() : SizedBox(),
          drawerAbout(),

          //O Fechar somente fecha a barra de ferramentas
          new ListTile(
            title: Text("Fechar menu"),
            trailing: Icon(Icons.close),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: Text("Sair do app"),
              trailing: Icon(Icons.close),
              onTap: () {
                _showDialog("Saindo", "Deseja realmente sair do UFPR ConVIDA?");
              })
        ],
      ),
    );
  }

  ListTile drawerLogin() {
    return ListTile(
        title: Text("Login"),
        trailing: Icon(Icons.person),
        onTap: () {
          _save.deleteAll();
          //Pop Drawer:
          Navigator.of(context).pop();

          //Push Login Screen:
          Navigator.of(context)
              .pushReplacementNamed("/login", arguments: "map");
        });
  }

  ListTile drawerSignup() {
    return ListTile(
        title: Text("Cadastro"),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          //Pop Drawer:
          Navigator.of(context).pop();
          //Push SignUp Screen:
          Navigator.of(context)
              .pushReplacementNamed("/signup", arguments: "map");
        });
  }

  Future<String> getUserProfile() async {
    dynamic response;
    String request;
    try {
      final userId = await _save.read(key: "userId");

      request = "$_url/users/$userId";
      var mapHeaders = getHeaderToken(_token);

      response = await http.get(Uri.parse(request), headers: mapHeaders);
      printRequisition(request, response.statusCode, "Get User Profile");
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        user = User.fromJson(jsonDecode(response.body));
        admin = user.adm;

      } else {
        //Comentado para que não dê erro quando o usuário entrar sem login
        // errorStatusCode(
        //     response.statusCode, context, "Erro ao Carregar Perfil, ${response.statusCode}");
      }

      return "Success";
    } catch (e) {
      showError("Erro desconhecido ao carregar Usuario", "Erro: $e", context);
      return "Failed";
    }
  }

  Future<bool> checkToken() async {
    _token = await _save.read(key: "token");

    try {
      if (_token == null) {
        return false;
      } else {
        _name = await _save.read(key: "name");
        _email = await _save.read(key: "email");
        _lastName = await _save.read(key: "lastName");
        _avatar = _name[0].toUpperCase();
        return true;
      }
    } catch (e) {
      _save.deleteAll();
      showError("Não foi possível carregar seus dados",
          "Sua sessão foi desfeita, favor logar novamente.", context);
      return false;
    }
  }

  List<Widget> getActions(int currentIndex, BuildContext context) {
    var widgetList = <Widget>[];

    if (currentIndex == 1 || currentIndex == 2) {
      widgetList.add(Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
        child: InkWell(
          child: ImageIcon(
            AssetImage('assets/icons/filter.png'),
            color: Color.fromRGBO(255, 73, 51, 1),
            size: 40,
          ),
          onTap: () {
            _openEndDrawer();
          },
        ),
      ));
    } else if((currentIndex == 0) && (admin == true)){
      widgetList.add(Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
        child: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.people, color: kPrimaryColor),
                title: Text('Listar administradores'),
              ),
              value: 0,
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.warning_amber_outlined, color: kPrimaryColor),
                title: Text('Eventos denunciados'),
              ),
              value: 1,
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.disabled_visible, color: kPrimaryColor),
                title: Text('Eventos desativados'),
              ),
              value: 2,
            ),
            const PopupMenuDivider(),
          ],
          onSelected: (result) {
            if (result == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListAdminWidget()
                  )
              ).then((value) => setState(() {}));
            } if (result == 1){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportWidget()),
              ).then((value) => setState(() {}));
            }else if (result == 2){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeactivatedEventsWidget()),
              ).then((value) => setState(() {}));
            }
          },
        ),
      ),
      );
    }else
      widgetList.add(SizedBox());
    return widgetList;
  }

  Widget getEndDrawer(int currentIndex) {
    if (currentIndex == 1 || currentIndex == 2) {
      return endDrawer();
    } else {
      return null;
    }
  }
}

class MyScaffoldBody extends StatelessWidget {
  MyScaffoldBody({Key key, this.index, this.filters}) : super(key: key);

  final int index;
  final Map filters;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return TestsWidget();
        break;

      case 1:
        return new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //Google's Map:
            MapWidget(filters: filters),
          ],
        );

        break;

      case 2:
        return EventsWidget(filters: filters);
        break;

      case 3:
        return TabWidget();
        break;

      default:
        return EventsWidget(filters: filters);
    }
  }
}

class DrawerLogout extends StatelessWidget {
  const DrawerLogout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _save = FlutterSecureStorage();

    return new ListTile(
        title: Text("Logout"),
        trailing: Icon(Icons.chevron_left),
        onTap: () async {
          //final firebaseToken = await _save.read(key: "firebaseToken");
          final userId = await _save.read(key: "userId");
          final token = await _save.read(key: "token");
          //removeFirebaseToken(token, firebaseToken, userId, context);

          _save.deleteAll();

          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/main');
        });
  }
}